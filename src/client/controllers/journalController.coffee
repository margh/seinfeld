module.exports = [
  'dayService',
  class JournalController
    constructor: (dayService) ->
      window.jctrl = this
      @service = dayService
      @day = dayService.selected

    enterDay: =>
      @day.checked = !@day.checked
      @service.enterDay @day

    getArrowPosition: ->
      if @day.moment
        if @day.moment.day() is 0
          return 7
        else
          return @day.moment.day()
      return -1

    displayDay: ->
      return @day.moment.format("dddd, MMMM Do YYYY")
]