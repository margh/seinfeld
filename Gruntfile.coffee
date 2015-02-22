module.exports = (grunt) ->
  grunt.initConfig
    env:
      default:
        push:
          PATH:
            value: './node_modules/.bin'
            delimiter: ':'

    # Compiles coffee into browser-ready js
    browserify:
      app:
        files: 'public/tmp/core.js': ['src/client/entry.coffee']
        options:
          transform: ['coffeeify']
          browserifyOptions:
            extensions: ['.coffee']
            debug: true

    # Converts html templates into js angular templates
    html2js:
      app:
        options:
          rename: (name) ->
            name = name.replace 'client/', ''
            name = name.replace '.html', ''
            return name
        src: ['src/client/templates/**/*.html']
        dest: 'public/tmp/templates.js'


    # Concat and minify JS deps
    uglify:
      lib:
        options:
          sourceMap: true
          sourceMapIncludeSources: true
          beautify: true
        files:
          'public/tmp/lib.js': [
            'bower_components/jquery/dist/jquery.js'
            'bower_components/lodash/lodash.js'
            'bower_components/angular/angular.js'
            'bower_components/angular-ui-utils/ui-utils.js'
            'bower_components/angular-cookies/angular-cookies.js'
            'bower_components/angular-animate/angular-animate.js'
            'bower_components/moment/moment.js'
            'bower_components/bootstrap/dist/js/bootstrap.js'
          ]

      # Compiles all debug js files into one prod ready js file
      dist:
        options:
          sourceMap: false
        files:
          'public/js/cal.js': [
            'public/tmp/lib.js'
            'public/tmp/templates.js'
            'public/tmp/core.js'
          ]

    # Build bootstrap with custom overrides and compile bespoke less
    less:
      app:
        files:
          'public/tmp/bootstrap.css': 'src/client/less/bootstrap.less'
          'public/tmp/styles.css': 'src/client/less/styles.less'

    # Compiles all custom and dep styles into one css file
    cssmin:
      app:
        files:
          'public/css/main.css': [
            'public/tmp/bootstrap.css'
            'bower_components/font-awesome/css/font-awesome.css'
            'public/tmp/styles.css'
          ]

    # Copy fonts from libraries
    copy:
      fonts:
        files: [
          {
            cwd: 'bower_components/bootstrap/dist/fonts/'
            src: ['*']
            dest: 'public/fonts'
            expand: true
            filter: 'isFile'
          }
          {
            cwd: 'bower_components/font-awesome/fonts/'
            src: ['*']
            dest: 'public/fonts'
            expand: true
            filter: 'isFile'
          }
        ]

    # Runs the Express server
    express:
      dev:
        options:
          opts: ['node_modules/coffee-script/bin/coffee']
          script: 'src/server/server.coffee'

    # Watch these files and re-run the specified tasks when they change
    watch:
      browserify:
        files: ['src/client/**/*.coffee']
        tasks: ['browserify:app']
      templates:
        files: ['src/client/templates/**/*.html']
        tasks: ['html2js']
      less:
        files: ['src/client/less/**/*.less']
        tasks: ['less:app', 'build:css']
      server:
        files: ['src/server/**/*.coffee']
        tasks: ['server:dev']
      livereload:
        options:
          livereload: true
        files: [
          'public/css/main.css'
          'public/index.html'
          'public/js/*.*'
        ]

    # Cleans (deletes files in) these folders
    clean:
      all: ['public']
      dev: ['public/tmp/*']
      dist: ['public/tmp']

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-html2js'
  grunt.loadNpmTasks 'grunt-newer'

  grunt.registerTask 'server:dev', [
    'express:dev'
  ]

  grunt.registerTask 'build:js', [
    'browserify:app'
    'html2js:app'
  ]

  grunt.registerTask 'build:css', [
    'cssmin:app'
  ]

  grunt.registerTask 'build:dev', [
    'clean:dev'
    'newer:uglify:lib'
    'build:js'
    'less:app'
    'build:css'
    'newer:copy:fonts'
  ]

  grunt.registerTask 'build:dist', [
    'clean:all'
    'build:js'
    'uglify:lib'
    'uglify:dist'
    'clean:dist'
    'less:app'
    'build:css'
    'copy:fonts'
  ]

  grunt.registerTask 'dev', ['build:dev', 'server:dev', 'watch']
  grunt.registerTask 'dist', ['build:dist']

  # grunt.registerTask 'test', ['build:js', 'karma:once']
  # grunt.registerTask 'test-watch', ['build:js', 'karma:unit']
  # grunt.registerTask 'e2e', ['build', 'shell:update-webdriver', 'protractor']
  # grunt.registerTask 't', 'test'

  # grunt.registerTask 'update-webdriver', 'shell:update-webdriver'

  grunt.registerTask 'default', 'test'

  grunt.task.run 'env:default'
