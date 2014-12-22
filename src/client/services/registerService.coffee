errorHandler = (data, status, headers, config) ->
  console.log status, data

module.exports = [ '$http', ($http) ->
  new class RegisterService
    register: (formData, cb) ->
      $http.put('/days/all')
        .success (res) ->
          cb(null, res)
        .error errorHandler
]