module.exports = class LoginController
  constructor: (@service) ->
    @model =
      email: 'nathan@admin'
      password: 'administration'

    @authenticated = @service.isAuthenticated()
    @username      = @service.getUsername()

  reset: =>
    @model.email = ''
    @model.password = ''

  submit: =>
    login =
      email: @model.email
      password: @model.password
    @service.login(login, @success, @fail)

  success: (user) =>
    @reset()
    @authenticated = true
    @username = user.username

  fail: (e) =>
    console.log 'login failed'