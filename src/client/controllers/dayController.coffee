module.exports = [
  'dayService',
  class DayController
    constructor: (dayService) ->

      @service = dayService

    monthIsActive: =>
      return @day.month() is @service.selected.moment.month()
]