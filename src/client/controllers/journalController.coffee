module.exports = [
  'dayService',
  class JournalController
    constructor: (dayService) ->
      window.jctrl = this
      @service = dayService
      @day = dayService.selected

      @noteDm = null

    checkDay: =>
      @service.toggleDay @day
      @service.enterDay @day

    addNote: ->
      @day.notes.push @noteDm
      @service.enterDay @day

    getArrowPosition: ->
      if @day.moment
        return @day.moment.day() + 1

    displayDay: ->
      return @day.moment.format("dddd, MMMM Do YYYY")

    dayChecked: ->
      return @day.checked

    getNotes: ->
      return @day.notes
]