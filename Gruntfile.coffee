module.exports = (grunt) ->
  grunt.initConfig
    env:
      default:
        push:
          PATH:
            value: './node_modules/.bin'
            delimiter: ':'

    browserify:
      app:
        files: 'public/js/core.js': ['src/client/entry.coffee']
        options:
          transform: ['coffeeify']
          browserifyOptions:
            extensions: ['.coffee']
            debug: true

    html2js:
      app:
        options:
          rename: (name) ->
            name = name.replace 'client/', ''
            name = name.replace '.html', ''
            return name
        src: ['src/client/templates/**/*.html']
        dest: 'public/js/templates.js'

    uglify:
      lib:
        options:
          sourceMap: true
          sourceMapIncludeSources: true
          beautify: true
        files:
          'public/js/lib.js': [
            'bower_components/jquery/dist/jquery.js'
            'bower_components/lodash/dist/lodash.js'
            'bower_components/angular/angular.js'
            'bower_components/angular-ui-utils/ui-utils.js'
            'bower_components/angular-cookies/angular-cookies.js'
            'bower_components/moment/moment.js'
            'bower_components/semantic-ui/dist/semantic.js'
          ]

      dist:
        options:
          sourceMap: false
        files:
          'public/js/app.js': [
            'public/js/lib.js'
            'public/js/app.js'
            'public/js/templates.js'
          ]

    cssmin:
      app:
        files:
          'public/css/main.css': [
            'bower_components/semantic-ui/dist/semantic.css'
            'public/css/styles.css'
          ]

    copy:
      themes:
        cwd: 'bower_components/semantic-ui/dist/themes/'
        src: ['**/*']
        dest: 'public/themes'
        expand: true
        filter: 'isFile'

    express:
      dev:
        options:
          opts: ['node_modules/coffee-script/bin/coffee']
          port: 40080
          script: 'src/server/server.coffee'

    watch:
      browserify:
        files: ['src/client/**/*.coffee']
        tasks: ['browserify:app']
      templates:
        files: ['src/client/templates/**/*.html']
        tasks: ['html2js']
      livereload:
        options:
          livereload: true
        files: [
          'public/css/main.css'
          'public/index.html'
          'public/js/*.*'
        ]

    clean:
      app: ['app']
      dev: ['public/js/*']
      dist: ['public/js/*']

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
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
    'build:css'
    'newer:copy:themes'
  ]

  grunt.registerTask 'build:dist', [
    'clean:app'
    'build:js'
    'uglify:lib'
    'uglify::dist'
    'clean:dist'
    'build:css'
    'copy:themes'
    'jade:dist'
  ]

  grunt.registerTask 'dev', ['build:dev', 'server:dev', 'watch']
  # grunt.registerTask 'dist', ['build:dist', 'server:dev']

  # grunt.registerTask 'test', ['build:js', 'karma:once']
  # grunt.registerTask 'test-watch', ['build:js', 'karma:unit']
  # grunt.registerTask 'e2e', ['build', 'shell:update-webdriver', 'protractor']
  # grunt.registerTask 't', 'test'

  # grunt.registerTask 'update-webdriver', 'shell:update-webdriver'

  grunt.registerTask 'default', 'test'

  grunt.task.run 'env:default'
