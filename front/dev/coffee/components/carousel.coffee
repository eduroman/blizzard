
app.carousel = 
		
	current: 0
	duration: 5000
	time: 0
	timeout: false
	
	init: ->

		el = $(".carousel")
		app.carousel.go(el,0,true)
		app.carousel.setBar(el)

		$(".carousel-thumbnail").click ->
			parent = $(this).closest(".carousel")
			app.carousel.go parent, $(this).index()

	next: (el) ->
		next = el.find(".carousel-content.current").index() + 1
		next = 0 if !el.find(".carousel-content").eq(next).length
		this.go(el,next)

	go: (el,to,firstime=false) ->

		this.time = 0
		this.current = to
		delay = 200
		delay = 0 if firstime

		el.find(".current").addClass("out").removeClass("current")
		el.find(".carousel-thumbnail").find(".bar").css width: 0+"%"
		el.find(".carousel-thumbnail").eq(to).addClass("current")
		el.find(".carousel-bg").eq(to).addClass("current")
		setTimeout ->
			el.find(".out").removeClass("out")
			el.find(".carousel-content").eq(to).addClass("current")
		,delay

		this.autoplay(el)

	autoplay: (el) ->
		clearTimeout app.carousel.timeout
		app.carousel.timeout = setTimeout ->
			app.carousel.next(el)
		,this.duration

	setBar: (el) ->

		setInterval ->

			app.carousel.time += 50

			bar = el.find(".carousel-thumbnail.current").find(".bar")
			width = app.carousel.time * 100 / app.carousel.duration
			width = 100 if width > 100
			bar.css
				width: width+"%"

		,50



