app.bg =
	init: ->

		$(".bg").each ->
			bg  = $(this)
			src = bg.find("img").attr("src")
			bg.css
				'background-image': 'url('+src+')'
			bg.imagesLoaded ->
				bg.addClass("bg-loaded")