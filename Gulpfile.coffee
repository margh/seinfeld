browserify = require 'browserify'
gulp = require 'gulp'
source = require 'vinyl-source-stream'
watchify = require 'watchify'
{spawn, exec} = require 'child_process'

# uglify = require 'uglify-js'

errorHandler = (e) ->
  console.error e
  @emit 'end'

gulp.task 'watchify', ->
  browserifyOptions =
    extensions: ['.coffee']
    debug: true
    # Watchify args
    cache: {}
    packageCache: {}
    fullPaths: true

  bundler = watchify(browserify('./src/client/entry.coffee', browserifyOptions).transform('coffeeify/no-debug'))
  
  rebundle = ->
    bundler.bundle()
      .on 'error', errorHandler
      .pipe source 'core.js'
      .pipe gulp.dest './public/js'
    console.log 'Recompiled JS'
  bundler.on 'update', rebundle

  return rebundle()

gulp.task 'server', ->  
  server = spawn 'node_modules/coffee-script/bin/coffee', ['src/server/server.coffee']
  server.stdout.on 'data', (data) -> console.warn data.toString()
  server.stderr.on 'data', (err) -> console.warn err.toString()

gulp.task 'dev', ['server', 'watchify']