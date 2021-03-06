# coffeelint: disable=max_line_length

gulp = require 'gulp'
webBuildTasks = require 'web-build-tasks'

cdnEntries = [
  {
    file: '/bower_components/jquery/dist/jquery.min.js'
    package: 'jquery'
    cdn: 'https://code.jquery.com/jquery-${ version }.min.js'
  }
  {
    file: '/bower_components/bootstrap/dist/css/bootstrap.min.css'
    package: 'bootstrap'
    cdn: 'https://maxcdn.bootstrapcdn.com/bootstrap/${ version }/css/bootstrap.min.css'
  }
  {
    file: '/bower_components/bootstrap/dist/js/bootstrap.min.js'
    package: 'bootstrap'
    cdn: 'https://maxcdn.bootstrapcdn.com/bootstrap/${ version }/js/bootstrap.min.js'
  }
]

webBuildTasks.define gulp,
  srcPath: './src'
  destPath: './dist/public'
  scriptPath: '/script'
  cdnEntries: cdnEntries
