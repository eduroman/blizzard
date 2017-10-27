

app.scroll =

	init: ->

		if $(window).width()>=960
			app.scroll.dscroll(0)
			$(window).scroll ->	
				scroll = $(window).scrollTop()
				app.scroll.dscroll(scroll)
				app.scroll.sticky(scroll)

		else
			$(".dscroll").addClass("dscroll-in")


		# Go to
		$("[data-goto]").click (e) ->
			to = $( $(this).attr "data-goto" )
			app.scroll.goto to
			e.preventDefault()


	dscroll: (scroll) ->

		# Mostrar en scroll

		if $(".dscroll").length
			element_top_prev  = 0
			element_top_delay = 0

			$(".dscroll:visible").each ->
				element = $(this)
				element_top = element.offset().top
				
				if scroll + $(window).height() > element_top
					element.addClass "dscroll-in"

					if element_top == element_top_prev
						element_top_delay++
						delay = element_top_delay*0.2
						element.css
							'-webkit-animation-delay': delay+"s"
							'animation-delay': delay+"s"
					else
						element_top_delay=0

					element_top_prev = element_top

				if scroll + $(window).height() <= element_top
					element.removeClass "dscroll-in"

	sticky: (scroll) ->

		if $(".sticky").length

			$(".sticky").each ->

				if scroll > $(this).parent().offset().top
					$(this).addClass("sticky-on")
				else
					$(this).removeClass("sticky-on")
		else
			$("body").addClass("body-header-fixed")



	goto: (to,add=false,seconds=1000) ->
		#add = $("header").height() if !add
		add = 60 if !add
		top = to.offset().top - add
		$("body").animate
			scrollTop: top
		,seconds

