_ = require 'underscore'
moment = require 'moment'
twix = require 'twix'

# Vanilla Classes
Day = require './../models/day'

getMonthArray = -> 
  days = []
  start = moment().startOf('month')
  end   = moment().endOf('month')
  range = start.twix(end).iterate('days')
  while range.hasNext()
    days.push range.next()
  return days

module.exports = class CalendarController
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
    @service.enterDay(day, @response)

  response: (e) =>
    if e then console.log 'do something about errros'
    console.log 'great success'