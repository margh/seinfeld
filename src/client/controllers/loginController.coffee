module.exports = class LoginController
  constructor: (@service) ->
    @model =
      email: 'nathan@admin'
      password: 'administration'

    @authenticated = false
    @username = ''

  reset: =>
    @model.email = ''
    @model.password = ''
    
  submit: =>
    login =
      email: @model.email
      password: @model.password
    @service.login(login, @response)
    @reset()

  response: (e, res) =>
    if e then return console.log 'do something about errros'
    console.log res
    @authenticated = true
    @username = res.username