


app.gmap =

	init: ->
		
		if $(".map").length

			$("header").append "<script src='http://maps.google.com/maps/api/js?libraries=places&key=AIzaSyCXnqJm-8BJediM44VPujWSYIwqIpa3V-o'></script>"
			
			setTimeout ->
				setInterval ->
					top = $(window).scrollTop() + $(window).height()
					$(".map:visible:not(.map-ready)").each ->
						if top > $(this).offset().top
							app.gmap.insert $(this)
				,500
			,1000


	insert: (m) ->

		if m.length && !m.hasClass("map-ready")

			# Markers & infowindows
			markers = new Array()
			infowindow = false

			# Config
			map_lat = m.find(".map-maker[data-show]").attr("data-lat")
			map_lng = m.find(".map-maker[data-show]").attr("data-lng")

			# Options
			mapOptions =
				center: new google.maps.LatLng(map_lat,map_lng)
				zoom: 14
				mapTypeId: google.maps.MapTypeId.ROADMAP
				disableDefaultUI: true
				scrollwheel: false
				streetViewControl: false
				backgroundColor: "#f4f4f4"
				window:
					marker: {}
					show: false
					closeClick: ->
						this.show = false
					options:
						boxClass: "map-infowindow"
						closeBoxMargin: "5px"
						pixelOffset: new google.maps.Size(-110, -85, 'px', 'px');
				styles: [
				    {
				        "featureType": "all",
				        "elementType": "labels.text.fill",
				        "stylers": [
				            {
				                "saturation": 36
				            },
				            {
				                "color": "#333333"
				            },
				            {
				                "lightness": 40
				            }
				        ]
				    },
				    {
				        "featureType": "all",
				        "elementType": "labels.text.stroke",
				        "stylers": [
				            {
				                "visibility": "on"
				            },
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 16
				            }
				        ]
				    },
				    {
				        "featureType": "all",
				        "elementType": "labels.icon",
				        "stylers": [
				            {
				                "visibility": "off"
				            }
				        ]
				    },
				    {
				        "featureType": "administrative",
				        "elementType": "geometry.fill",
				        "stylers": [
				            {
				                "color": "#fefefe"
				            },
				            {
				                "lightness": 20
				            }
				        ]
				    },
				    {
				        "featureType": "administrative",
				        "elementType": "geometry.stroke",
				        "stylers": [
				            {
				                "color": "#fefefe"
				            },
				            {
				                "lightness": 17
				            },
				            {
				                "weight": 1.2
				            }
				        ]
				    },
				    {
				        "featureType": "landscape",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#f5f5f5"
				            },
				            {
				                "lightness": 20
				            }
				        ]
				    },
				    {
				        "featureType": "poi",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#f5f5f5"
				            },
				            {
				                "lightness": 21
				            }
				        ]
				    },
				    {
				        "featureType": "poi.park",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#dedede"
				            },
				            {
				                "lightness": 21
				            }
				        ]
				    },
				    {
				        "featureType": "road.highway",
				        "elementType": "geometry.fill",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 17
				            }
				        ]
				    },
				    {
				        "featureType": "road.highway",
				        "elementType": "geometry.stroke",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 29
				            },
				            {
				                "weight": 0.2
				            }
				        ]
				    },
				    {
				        "featureType": "road.arterial",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 18
				            }
				        ]
				    },
				    {
				        "featureType": "road.local",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 16
				            }
				        ]
				    },
				    {
				        "featureType": "transit",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#f2f2f2"
				            },
				            {
				                "lightness": 19
				            }
				        ]
				    },
				    {
				        "featureType": "water",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#e9e9e9"
				            },
				            {
				                "lightness": 17
				            }
				        ]
				    }
				]

			# Create map

			if !m.find(".map-gmap").length
				m.append '<div class="map-gmap"></div>'

			map = new google.maps.Map(m.find(".map-gmap")[0], mapOptions)


			# Custom zoom buttons

			m.append ''+
	            '<div class="map-zoom">'+
	                '<button class="map-zoom-button map-zoom-in  btn btn-sm btn-white"><i class="fa fa-plus"></i></button>'+
	                '<button class="map-zoom-button map-zoom-out btn btn-sm btn-white"><i class="fa fa-minus"></i></button>'+
	            '</div>'

			m.find(".map-zoom-in").click ->
				map.setZoom map.getZoom() + 1
				false

			m.find(".map-zoom-out").click ->
				map.setZoom map.getZoom() - 1
				false


			# Load markers

			m.find(".map-marker").each ->

				m_marker          = $(this)
				m_marker_content  = "<div class='map-infowindow'>" + m_marker.html() + "</div>"
				m_marker_lat      = m_marker.attr("data-lat")
				m_marker_lng      = m_marker.attr("data-lng")
				m_marker_index    = m_marker.index()

				marker = new google.maps.Marker(
					position: new google.maps.LatLng(m_marker_lat, m_marker_lng)
					animation: google.maps.Animation.DROP
					map: map
					icon: $("body").attr("data-url-assets")+"img/icon-marker.png"
				)

				marker['content'] = m_marker_content
				marker['index']   = m_marker_index


				# Click infowindow
				
				marker['infowindow'] = new google.maps.InfoWindow(content:m_marker_content)

				google.maps.event.addListener map, 'click', ->
					marker['infowindow'].close()


				if m_marker.html().length
					google.maps.event.addListener marker, "click", ->
						for ma in markers
							ma['infowindow'].close()
						marker['infowindow'].open map, this

				if m_marker.attr("data-show")
					marker['infowindow'].open map, marker
					map.setCenter(marker.getPosition())


				markers.push(marker)



			m.addClass("map-ready")

