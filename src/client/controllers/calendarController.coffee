module.exports = [
  'dayService',
  class CalendarController
    constructor: (dayService) ->
      @service = dayService
      @days = @service.dates

      @service.getEntries()
      @selectDay @days[@days.length - 1] # default to today

    selectDay: (day) =>
      @service.selectDay(day)

    enterDay: (day) =>
      @service.toggleDay(day)
      @service.enterDay(day)
      @service.selectDay(day)

    isActiveMonth: (day) =>
      if @service.selected
        return day.moment.month() is @service.selected.moment.month()
      else
        return false

    isActiveWeek: (day) =>
      if @service.selected
        return day.moment.week() is @service.selected.moment.week()
      else
        return false

    response: (e) =>
      if e then console.log 'do something about errros'
      console.log 'great success'
]