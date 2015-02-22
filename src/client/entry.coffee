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

app.directive 'calendar', ['dayService', (dayService) ->
  restrict: 'E'
  templateUrl: 'templates/calendar'
  controller: 'CalendarController as calCtrl'
  link: ($scope, $elm, attrs) ->
    _.defer -> $(document).scrollTop($(document).height())
    minHeight = 200

    prependDays = ->
      if $(document).scrollTop() < minHeight
        oldHeight = $(document).height()
        dayService.prependDays()
        $scope.$digest()
        window.scrollBy(0, $(document).height() - oldHeight);

    scrollToTodayBtn = ->
      distanceFromBottom = $(document).height() - ($(window).height() + $(document).scrollTop())
      if distanceFromBottom > (window.innerHeight / 7) # close enough to day size
        $('#scrollToTodayBtn').css('opacity', 1)
      else
        $('#scrollToTodayBtn').css('opacity', 0)

    $(document).scroll(_.throttle scrollToTodayBtn, 500)
    $(document).scroll(_.throttle prependDays, 1000)
    $('#scrollToTodayBtn').click ->
      $(document).scrollTop($(document).height())
]

app.directive 'journal', ->
  restrict: 'E'
  templateUrl: 'templates/journal'
  controller: 'JournalController as jCtrl'

app.directive 'day', ->
  restrict: 'E'
  templateUrl: 'templates/day-entry'
  controller: 'DayController as dCtrl'
  link: ($scope, $elm, attrs) ->
    journalTickOffset = (window.innerHeight / 100) * 2
    $elm.on 'click', ->
      $('body').animate
        scrollTop:
          ($elm.offset().top - window.innerHeight) + ($('#journal').height() + journalTickOffset)