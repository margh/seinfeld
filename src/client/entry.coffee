_ = require 'underscore'
moment = require 'moment'
twix = require 'twix'

DayService = require './services/dayService'

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

app.service 'dayService', DayService

app.controller 'calCtrl', ['dayService', class CalCtrl
  constructor: (dayService) ->
    @service = dayService
    @days = _.map getMonthArray(), (dateObj) -> 
      new Day {moment: dateObj, dateString: dateObj.format('DD-MM-YYYY')}

    @getDays()

  getDays: =>
    cal = this
    @service.getDays (e, dayList) ->
      if e then return false
      for dayData in dayList then do (dayData) ->
        displayDay = _.findWhere(cal.days, {dateString: dayData.dateString})
        if displayDay
          displayDay.checked = true

  enterDay: (day) =>
    day.toggle()
    @service.enterDay(day)
]

app.directive 'navbar', ->
  restrict: 'E'
  templateUrl: '/templates/navbar.html'

app.directive 'register', ->
  restrict: 'E'
  templateUrl: '/templates/register-modal.html'

app.directive 'calendar', ->
  restrict: 'E'
  controller: 'calCtrl as cal'
  templateUrl: '/templates/calendar.html'

app.directive 'day', ->
  restrict: 'E'
  templateUrl: '/templates/day-entry.html'