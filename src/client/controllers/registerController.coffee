module.exports = [
  'authenticationService',
  class LoginController
    constructor: (@service) ->
      @model =
        email: 'nathan@admin'
        username: 'nrashleigh'
        password: 'administration'
        confirmPassword: 'administration'

    cancel: =>
      @model.email = ''
      @model.password = ''
      @model.username = ''
      @model.confirmPassword = ''

    submit: =>
      registration = {
        email: @model.email
        username: @model.username
        password: @model.password
      }
      @service.register(registration, @response)

    response: (e) =>
      if e then console.log 'do something about errros'

      console.log 'good jaaaaab'
]