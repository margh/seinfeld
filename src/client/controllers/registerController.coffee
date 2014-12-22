module.exports = class LoginController
  constructor: (@service) ->
    @model =
      email: ''
      password: ''
      confirmPassword: ''

  passwordsMatch: =>
    return @model.password is @model.confirmPassword

  submit: =>
    @service.register(@model)