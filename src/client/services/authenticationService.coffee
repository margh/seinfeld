errorHandler = (data, status, headers, config) ->
  console.log status, data

module.exports = [ '$http', '$cookies', ($http, $cookies) ->
  new class AuthenticationService
    isAuthenticated: ->
      !!$cookies.login

    getUsername: ->
      $cookies.username

    profile: (success, fail) ->
      $http.get('/profile')
        .success success
        .fail fail

    register: (registrationData, cb) ->
      $http.post('/users', registrationData)
        .success (res) ->
          cb(null, res)
        .error errorHandler

    login: (loginData, success, fail) ->
      console.log loginData
      $http.post('/login', loginData)
        .success success
        .error fail

    logout: (cb) ->
      $http.post('/logout')
        .success (res) ->
          cb(null, res)
        .error errorHandler
]