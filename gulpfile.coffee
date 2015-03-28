'use strict'

gulp = require 'gulp'
$ = (require 'gulp-load-plugins') lazy: false

paths =
  jshint: [
    './bin/*'
  ]
  coffeelint: [
    './gulpfile.coffee'
    './test/*.coffee'
  ]
  watch: [
    './gulpfile.coffee'
    './bin/**/*.js'
    './test/**/*.coffee'
  ]
  tests: [
    './test/**/*.coffee'
  ]

gulp.task 'jshint', ->
  gulp.src paths.jshint
    .pipe $.jshint()
    .pipe $.jshint.reporter()

gulp.task 'coffeelint', ->
  gulp.src paths.coffeelint
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()

gulp.task 'compile', ['jshint', 'coffeelint'], ->
  gulp.src paths.tests
    .pipe $.sourcemaps.init()
    .pipe($.coffee({ bare: true }).on('error', $.util.log))
    .pipe $.sourcemaps.write()
    .pipe $.espower()
    .pipe gulp.dest('./compile')

gulp.task 'watch', ['test'], ->
  gulp.watch paths.watch, ['test']

gulp.task 'test', ['compile'], ->
  gulp.src ['./compile/**/*.js'], {cwd: __dirname}
    .pipe $.mocha()

gulp.task 'default', ['test']
