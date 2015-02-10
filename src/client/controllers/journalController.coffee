module.exports = [
  'dayService',
  class JournalController
    constructor: (dayService) ->
      window.jctrl = this
      @service = dayService
      @day = dayService.selectedDay

    enterDay: (day) =>
      day.toggle()
      @service.enterDay(day, @response)

    getArrowPosition: ->
      if @day.moment
        if @day.moment.day() is 0
          return 7
        else
          return @day.moment.day()
      return -1

    response: (e) =>
      if e then console.log 'do something about errros'
      console.log 'great success'
]