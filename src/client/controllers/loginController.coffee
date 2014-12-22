module.exports = class LoginController
  constructor: ->
    @model =
      email: ''
      password: ''

  submit: ->
    console.log @model