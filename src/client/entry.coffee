app = angular.module 'calApp', []

app.controller 'calCtrl', class CalCtrl
  constructor: ->
    @days = ['Monday', 'Tuesday', 'Wednesday']
