errorHandler = (data, status, headers, config) ->
  console.log status, data

module.exports = [ '$http', ($http) ->
  return {
    selectedDay: {}

    getDays: (cb) ->
      $http.get('/days/all')
        .success (res) ->
          cb(null, res)
        .error errorHandler

    enterDay: (day, cb) ->
      $http.post("/days/#{day.dateString}", day)
        .success (res) ->
          # TODO Check if res is ok
          cb(null, res)
        .error errorHandler

    # This sucks
    # but you have to do it because
    # if you directly set the object your controllers
    # will lose the reference to the object and won't
    # watch for value changes.
    selectDay: (day) ->
      for key, value of day
        @selectedDay[key] = value
  }
]