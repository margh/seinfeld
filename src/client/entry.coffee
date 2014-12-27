# ng services
DayService = require './services/dayService'
AuthenticationService = require './services/authenticationService'

# ng controllers
LoginController = require './controllers/loginController'
RegisterController = require './controllers/registerController'
CalendarController = require './controllers/calendarController'

app = angular.module 'calApp', ['ui.utils']

app.service 'dayService', DayService
app.service 'authenticationService', AuthenticationService

app.controller 'LoginController'   , ['authenticationService', LoginController]
app.controller 'RegisterController', ['authenticationService', RegisterController]
app.controller 'CalendarController', ['dayService', CalendarController]

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