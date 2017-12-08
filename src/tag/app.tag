app
	nav.navbar.navbar-default
		.container-fluid
			// Brand and toggle get grouped for better mobile display
			.navbar-header
				button.navbar-toggle.collapsed(type='button', data-toggle='collapse', data-target='#bs-example-navbar-collapse-1', aria-expanded='false')
					span.sr-only Toggle navigation
					span.icon-bar
					span.icon-bar
					span.icon-bar
				a.navbar-brand(href='#') Riot Sample
			// Collect the nav links, forms, and other content for toggling
			#bs-example-navbar-collapse-1.collapse.navbar-collapse
				ul.nav.navbar-nav
					li(each="{link in links}")
						a(href="{link}") {link}
			// /.navbar-collapse
		// /.container-fluid
	.container-fluid
		#content
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

	script.
		this.links = ['/', '#', '#fruit', '#search?keyword=hello']

top
	jst
	script.
		//https://qiita.com/t-yng/items/c8c4728ae36afdd2aaac
		const obs = riot.observable()

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
