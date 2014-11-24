moment = require 'moment'
twix = require 'twix'

app = angular.module 'calApp', []

getMonthArray = -> 
  days = []
  start = moment().startOf('month')
  end   = moment().endOf('month')
  range = start.twix(end).iterate('days')
  while range.hasNext()
    days.push range.next()
  return days


app.controller 'calCtrl', class CalCtrl
  constructor: ->
    @days = getMonthArray()