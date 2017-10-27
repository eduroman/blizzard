app = []

#=include components/*.coffee

$(document).ready ->

	app.bg.init()
	app.slider.init()
	app.gallery.init()
	app.scroll.init()
	app.gmap.init()
	app.forms.init()

	app.carousel.init()

	$(".header-hamburger").click ->
		if !$("header").hasClass("header-nav-in")
			$("header").addClass "header-nav-in"
		else
			$("header").addClass "header-nav-out"
			setTimeout ->
				$("header").removeClass "header-nav-in header-nav-out"
			,200


