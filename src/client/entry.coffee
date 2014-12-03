moment = require 'moment'
twix = require 'twix'

app = angular.module 'calApp', []

class Day 
  constructor: (props) ->
    @checked = props.checked
    @dateString = props.dateString
    @moment = moment(@dateString, 'DD-MM-YYYY')

getMonthArray = -> 
  days = []
  start = moment().startOf('month')
  end   = moment().endOf('month')
  range = start.twix(end).iterate('days')
  while range.hasNext()
    days.push range.next()
  return days

app.controller 'calCtrl', ['$http', class CalCtrl
  constructor: (http) ->
    cal = this
    @days = []
    http.get('./december.json').success (data) ->
      for day in data then do (day) ->
        cal.days.push new Day day
      window.day = cal.days[0]

]

app.directive 'day', ->
  restrict: 'E'
  templateUrl: '/templates/day-entry.html'