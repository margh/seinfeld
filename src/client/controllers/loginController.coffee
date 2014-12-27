module.exports = class LoginController
  constructor: (@service) ->
    @model =
      email: 'nathan@admin'
      password: 'administration'

  reset: =>
    @model.email = ''
    @model.password = ''
    
  submit: =>
    login =
      email: @model.email
      password: @model.password
    @service.login(login, @response)
    @reset()

  response: (e) =>
    if e then console.log 'do something about errros'
    console.log 'logged innnn'