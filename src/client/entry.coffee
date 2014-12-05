Day = require './models/day'

app = angular.module 'calApp', []

app.controller 'calCtrl', ['$http', class CalCtrl
  constructor: (http) ->
    cal = this
    @days = []
    http.get('/days').success (res) ->
      for dayData in res then do (dayData) ->
        cal.days.push new Day dayData
]

app.directive 'day', ->
  restrict: 'E'
  templateUrl: '/templates/day-entry.html'