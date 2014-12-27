errorHandler = (data, status, headers, config) ->
  console.log status, data

module.exports = [ '$http', ($http) ->
  new class RegisterService
    register: (formData, cb) ->
      console.log formData
      # $http.put('/')
      #   .success (res) ->
      #     cb(null, res)
      #   .error errorHandler
]