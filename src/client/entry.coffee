_ = require 'underscore'
moment = require 'moment'
twix = require 'twix'

# Vanilla Classes
Day = require './models/day'

# ng services
DayService = require './services/dayService'
LoginService = require './services/loginService'
RegisterService = require './services/registerService'

# ng controllers
LoginController = require './controllers/loginController'
RegisterController = require './controllers/registerController'

app = angular.module 'calApp', ['ui.utils']

getMonthArray = -> 
  days = []
  start = moment().startOf('month')
  end   = moment().endOf('month')
  range = start.twix(end).iterate('days')
  while range.hasNext()
    days.push range.next()
  return days

app.service 'dayService', DayService
app.service 'loginService', LoginService
app.service 'registerService', RegisterService

app.controller 'LoginController', ['loginService', LoginController]

app.controller 'RegisterController', ['registerService', RegisterController]

app.controller 'CalendarController', ['dayService', class CalCtrl
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

app.directive 'login', ->
  restrict: 'E'
  templateUrl: '/templates/login.html'
  controller: 'LoginController as loginCtrl'

app.directive 'register', ->
  restrict: 'E'
  templateUrl: '/templates/register-modal.html'
  controller: 'RegisterController as regCtrl'

app.directive 'calendar', ->
  restrict: 'E'
  templateUrl: '/templates/calendar.html'
  controller: 'CalendarController as calCtrl'

app.directive 'day', ->
  restrict: 'E'
  templateUrl: '/templates/day-entry.html'