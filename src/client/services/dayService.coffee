errorHandler = (data, status, headers, config) ->
  console.log status, data

module.exports = [ '$http', ($http) ->
  new class DayService
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
]