module.exports = [
  'authenticationService'
  'dayService'
  class LoginController
    constructor: (@authenticationService, @dayService) ->
      window.lctrl = this
      @model =
        email: 'nathan@admin'
        password: 'administration'

      @authenticated = @authenticationService.getAuthenticated()
      @username      = @authenticationService.getUsername()

    reset: =>
      @model.email = ''
      @model.password = ''

    submit: =>
      login =
        email: @model.email
        password: @model.password
      @authenticationService.login(login, @success, @fail)

    success: (user) =>
      @reset()
      @authenticated = true
      @username = user.username
      @dayService.getEntries()

    fail: (e) =>
      console.log 'login failed'
]