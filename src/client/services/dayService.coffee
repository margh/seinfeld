moment = require 'moment'
twix = require 'twix'

# Vanilla Classes
Day = require './../models/day'

errorHandler = (data, status, headers, config) ->
  console.log status, data

getTwoMonths = (end) ->
  days  = []

  end ?= moment()
  start = moment(end).subtract(2,'months').startOf('week')
  range = start.twix(end).iterate('days')
  while range.hasNext()
    days.push range.next()
  return days

module.exports = [ '$http', ($http) ->
  dates = _.map getTwoMonths(), (momentObj) ->
    return new Day {moment: momentObj, dateString: momentObj.format('YYYY-MM-DD')}

  entries = []

  _updateDay = (entry) ->
    date = _.findWhere dates, {dateString: entry.dateString}
    if date
      _.assign date, entry

  return {
    selected: {}
    dates: dates
    entries: entries

    getEntries: ->
      $http.get('/entries/all')
        .success (res) =>
          entries = res
          # Update the date list with server date
          _.each res, _updateDay

          # Set the values of the selected day if it was returned
          # by the server
          if selectedUpdate = _.findWhere res, {dateString: @selected.dateString}
            @selectDay selectedUpdate

        .error errorHandler

    prependDays: ->
      finalDate = moment(dates[0].moment).subtract(1,'day') # no dupes of first day
      days = getTwoMonths(finalDate)
      days.reverse()
      _.each days, (momentObj) ->
        newDay = new Day {moment: momentObj, dateString: momentObj.format('YYYY-MM-DD')}
        entry = _.findWhere entries, {dateString: newDay.dateString}
        if entry
          _.assign newDay, entry
        dates.unshift newDay


    enterDay: (entry, cb) ->
      $http.post("/entries/#{entry.dateString}", entry)
        .success _updateDay
        .error errorHandler

    toggleDay: (day) ->
      day.checked = !day.checked

    # This sucks
    # but you have to do it because
    # if you directly set the object your controllers
    # will lose the reference to the object and won't
    # detect value changes.
    selectDay: (day) ->
      _.assign @selected, day
  }
]