module.exports = class LoginController
  constructor: (@service) ->
    @model =
      email: ''
      password: ''
      confirmPassword: ''

  passwordsMatch: =>
    console.log 'validating'
    return @model.password is @model.confirmPassword

  submit: =>
    console.log @model
    @service.register(@model)