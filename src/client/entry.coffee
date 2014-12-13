_ = require 'underscore'
moment = require 'moment'
twix = require 'twix'

Day = require './models/day'

app = angular.module 'calApp', []

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
    @days = _.map getMonthArray(), (dateObj) -> 
      new Day {moment: dateObj, dateString: dateObj.format('DD-MM-YYYY')}

    http.get('/days').success (res) ->
      for dayData in res then do (dayData) ->
        displayDay = _.findWhere(cal.days, {dateString: dayData.dateString})
        if displayDay
          displayDay.checked = true
]

app.directive 'day', ->
  restrict: 'E'
  templateUrl: '/templates/day-entry.html'