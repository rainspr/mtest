jst
  h4(class="{ text-warning: iswarn, text-danger: isdanger }") 現在時刻: { clock }

  script.
    import axios from 'axios'
    var self = this
    self.iswarn = false
    self.isdanger = false
    self.serverlist = [
      'https://ntp-a1.nict.go.jp/cgi-bin/json',
      'https://ntp-b1.nict.go.jp/cgi-bin/json'
    ]
    self.serverurl = self.serverlist[Math.floor(Math.random() * self.serverlist.length)]
    self.loaddate = Date.now()
    axios.get(self.serverurl + "?" + self.loaddate / 1000)
      .then(function(response) {
        self.datediff = ((response.data.st * 1000) + ((self.loaddate - (response.data.it * 1000)) / 2)) - self.loaddate
        updatetime()
      })
      .catch(function(response) {
        console.log(response)
        throw new Error("つながってない")
      })
    function updatetime() {
      self.nowdate = new Date(Date.now() + self.datediff)
      self.clock = dateprintf('%h時%i分%s.%u秒', self.nowdate)
      let nownum = self.nowdate.getHours()*100 + self.nowdate.getMinutes()
      switch(true){
        case (2225 <= nownum && nownum < 2229) :
          self.iswarn = true
          self.isdanger = false
          break
        case (2229 <= nownum && nownum < 2230) :
          self.iswarn = false
          self.isdanger = true
          break
        default :
          self.iswarn = false
          self.isdanger = false
      }
      self.update()
      setTimeout(updatetime, 50)
    }
    function zerofill(number,digit) {
      return ('00' + number).slice(digit * -1)
    }
    function dateprintf(format,date) {
      if (!format) {
        format = '%y/%m/%d %h:%i:%s.%u'
      }
      if (!(date instanceof Date)) {
        date = new Date()
      }
      let year = date.getFullYear(),
        month = zerofill(date.getMonth() + 1, 2),
        date_n = zerofill(date.getDate(), 2),
        hour = zerofill(date.getHours(), 2),
        minute = zerofill(date.getMinutes(), 2),
        second = zerofill(date.getSeconds(), 2),
        milli_second = zerofill(date.getMilliseconds(), 3)
      return format.replace(/(%*)%([ymdhisu])/g, function (a, escape_str, type) {
        if (escape_str.length % 2 === 0) {
          switch (type) {
            case 'y':
              type = year
              break
            case 'm':
              type = month
              break
            case 'd':
              type = date_n
              break
            case 'h':
              type = hour
              break
            case 'i':
              type = minute
              break
            case 's':
              type = second
              break
            case 'u':
              type = milli_second
              break
          }
        }
        return escape_str.replace(/%%/g, '%') + type
      })
    }


