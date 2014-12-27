module.exports = class LoginController
  constructor: (@service) ->
    @model =
      email: 'nathan@admin'
      password: 'administration'
      confirmPassword: 'administration'

  passwordsMatch: =>
    console.log 'validating'
    return @model.password is @model.confirmPassword

  cancel: =>
    @model.email = ''
    @model.password = ''
    @model.confirmPassword = ''

  submit: =>
    registration = {
      email: @model.email
      password: @model.password
    }
    @service.register(registration, @response)

  response: (e) =>
    if e then console.log 'do something about errros'

    console.log 'good jaaaaab'