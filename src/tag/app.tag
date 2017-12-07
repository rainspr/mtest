app
	nav
		a(each='{link in links}' href='{link}') {link}
	router
		route(path='')
			top
		route(path='fruit')
			fruit
		route(path='search..')
			search
		route(path='..')
			other

	style.
		a {
			margin: 1rem;
			font-size: 2rem;
		}

	script.
		this.links = ['/', '#', '#fruit', '#search?keyword=hello']

top
	h1 top page

fruit
	h1 fruit page

search
	h1 search page
	p(each='{value, key in query}') {key}: {value}

	script.
		import route from 'riot-route/lib/tag'
		this.on('route', () => this.query = route.query())

other
	h1 404