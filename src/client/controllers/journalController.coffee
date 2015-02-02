module.exports = [
  'dayService',
  class CalendarController
    constructor: (dayService) ->
      @service = dayService

    enterDay: (day) =>
      day.toggle()
      @service.enterDay(day, @response)

    response: (e) =>
      if e then console.log 'do something about errros'
      console.log 'great success'
]