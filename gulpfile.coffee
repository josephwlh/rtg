gulp = require('gulp')
riot = require 'gulp-riot'
browserSync = require('browser-sync')
reload = browserSync.reload
harp = require('harp')


basepath = __dirname + '/src/**/*.'

watchfilelist = [
  "jade"
  "html"
  "coffee"
  "js"
  "json"
]

watchfile = []

for i in watchfilelist
  file = basepath + i
  watchfile.push file

# tag to js
gulp.task 'riot', ->
  gulp.src __dirname + '/src/tag/**/*.tag'
    .pipe riot
      template: "jade"
    .pipe gulp.dest "./src/js/"

gulp.task 'serve', ->
  harp.server __dirname + '/src', { port: 9000 }, ->
    browserSync
      proxy: 'localhost:9000'
      open: true
      notify: styles: [
        'opacity: 0'
        'position: absolute'
      ]

    ###*
    # Watch for scss changes, tell BrowserSync to refresh main.css
    ###

    # gulp.watch '*.sass', ->
    #   reload 'main.css', stream: true
    #   return

    ###*
    # Watch for all other changes, reload the whole page
    ###
    gulp.watch './src/**/*.tag', ['riot']

    gulp.watch watchfile, ()-> reload()



gulp.task 'default', [ 'serve' , 'riot']