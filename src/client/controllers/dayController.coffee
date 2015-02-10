module.exports = [
  'dayService',
  class DayController
    constructor: (dayService) ->

      @service = dayService

    monthIsEven: =>
      return @day.month() % 2 # January is 0
]