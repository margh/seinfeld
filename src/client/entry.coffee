# ng services
DayService = require './services/dayService'
AuthenticationService = require './services/authenticationService'

# ng controllers
LoginController = require './controllers/loginController'
RegisterController = require './controllers/registerController'
CalendarController = require './controllers/calendarController'
DayController = require './controllers/dayController'
JournalController = require './controllers/journalController'

app = angular.module 'calApp', [
  'templates-app'
  'ui.utils'
  'ngCookies'
  'ngAnimate'
]

app.service 'dayService', DayService
app.service 'authenticationService', AuthenticationService

app.controller 'LoginController'   , LoginController
app.controller 'RegisterController', RegisterController
app.controller 'CalendarController', CalendarController
app.controller 'DayController'     , DayController
app.controller 'JournalController' , JournalController

app.directive 'navbar', ->
  restrict: 'E'
  templateUrl: 'templates/navbar'

app.directive 'login', ->
  restrict: 'E'
  templateUrl: 'templates/login'
  controller: 'LoginController as loginCtrl'

app.directive 'register', ->
  restrict: 'E'
  templateUrl: 'templates/register-modal'
  controller: 'RegisterController as regCtrl'

app.directive 'calendar', ->
  restrict: 'E'
  templateUrl: 'templates/calendar'
  controller: 'CalendarController as calCtrl'

app.directive 'journal', ->
  restrict: 'E'
  templateUrl: 'templates/journal'
  controller: 'JournalController as jCtrl'

app.directive 'day', ->
  restrict: 'E'
  templateUrl: 'templates/day-entry'
  controller: 'DayController as dCtrl'