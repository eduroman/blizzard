
gulp         = require("gulp")
jade         = require("gulp-jade")
stylus 		 = require('gulp-stylus')
coffee 		 = require('gulp-coffee');
livereload   = require("gulp-livereload")
addsrc       = require("gulp-add-src")
uglify       = require("gulp-uglify")
concat       = require("gulp-concat")
include      = require("gulp-include")


path_dev     = "dev"
path_dist    = "dist"
path_wp		 = "../backend/htdocs/content/themes/Salon/dist"

files =
	html :
		src : path_dev + "/jade/pages/*.jade"
		watch : path_dev + "/jade/**/*.jade"
		dest : path_dist

	css :
		src : path_dev + "/stylus/main.styl"
		watch : path_dev + "/stylus/**/*.styl"
		dest : path_dist + "/css"
		destwp : path_wp + "/css"

	js :
		src : path_dev + "/coffee/main.coffee"
		watch : path_dev + "/coffee/**/*.coffee"
		plugins : [
			"bower_components/jquery/dist/jquery.min.js",
			"bower_components/imagesloaded/imagesloaded.pkgd.min.js",
			"bower_components/hammerjs/hammer.min.js"
		]
		dest : path_dist + "/js"
		destwp : path_wp + "/js"

gulp.task "default", ->

	livereload.listen()
	gulp.watch("dist/**/*.css").on "change", livereload.changed
	
	gulp.watch files.html.watch,    [ "build-html" ]
	gulp.watch files.css.watch,     [ "build-css" ]
	gulp.watch files.js.watch,      [ "build-js" ]
	return

gulp.task 'build', [
	'build-css'
	'build-html'
	'build-js'
	'icons'
]

gulp.task "build-css", ->
	gulp.src(files.css.src)
		.pipe(stylus({'include css':true}))
		.pipe(gulp.dest(files.css.dest))
		.pipe(gulp.dest(files.css.destwp))
	return

gulp.task "build-html", ->
	gulp.src(files.html.src)
		.pipe(jade(pretty: true))
		.pipe(gulp.dest(files.html.dest))
	return

gulp.task "build-js", ->
	gulp.src(files.js.src)
		.pipe(include())
		.pipe(coffee(bare: true))
		.pipe(addsrc.prepend(files.js.plugins))
		.pipe(concat('main.js'))
		.pipe(uglify())
		.pipe(gulp.dest(files.js.dest))
		.pipe(gulp.dest(files.js.destwp))
	return

gulp.task 'icons', ->
    gulp.src('bower_components/fontawesome/fonts/**.*')
        .pipe(gulp.dest(path_dist+'/fonts'))
    return
