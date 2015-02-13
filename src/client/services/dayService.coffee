moment = require 'moment'
twix = require 'twix'

# Vanilla Classes
Day = require './../models/day'

errorHandler = (data, status, headers, config) ->
  console.log status, data

getDates = ->
  days  = []

  # Draw up to today
  today = moment()
  start = moment().subtract(2,'months').startOf('isoweek') # Make sure we start on a Monday (need isoweek)
  range = start.twix(today).iterate('days')
  while range.hasNext()
    days.push range.next()
  return days

module.exports = [ '$http', ($http) ->
  dates = _.map getDates(), (momentObj) ->
    return new Day {moment: momentObj, dateString: momentObj.format('DD-MM-YYYY')}

  _updateDay = (entry) ->
    date = _.findWhere dates, {dateString: entry.dateString}
    if date
      for key, value of entry
        date[key] = value

  return {
    selected: {}
    dates: dates

    getEntries: ->
      $http.get('/entries/all')
        .success (res) ->
          _.each res, _updateDay
        .error errorHandler

    enterDay: (entry, cb) ->
      $http.post("/entries/#{entry.dateString}", entry)
        .success _updateDay
        .error errorHandler

    # This sucks
    # but you have to do it because
    # if you directly set the object your controllers
    # will lose the reference to the object and won't
    # watch for value changes.
    selectDay: (day) ->
      for key, value of day
        @selected[key] = value
  }
]