errorHandler = (data, status, headers, config) ->
  console.log status, data

module.exports = [ '$http', ($http) ->
  new class AuthenticationService

    register: (registrationData, cb) ->
      $http.post('/users', registrationData)
        .success (res) ->
          cb(null, res)
        .error errorHandler

    login: (loginData, cb) ->
      console.log loginData
      $http.post('/login', loginData)
        .success (res) ->
          cb(null, res)
        .error errorHandler

    logout: (cb) ->
      $http.post('/logout')
        .success (res) ->
          cb(null, res)
        .error errorHandler
]