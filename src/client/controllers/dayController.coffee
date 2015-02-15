module.exports = [
  'dayService',
  class DayController
    constructor: (dayService) ->
      @service = dayService

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

    isActiveDay: (day) =>
      if @service.selected
        return day.dateString is @service.selected.dateString
      else
        return false
]