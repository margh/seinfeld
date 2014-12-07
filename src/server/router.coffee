mongoose = require 'mongoose'

UserController = require './controllers/userController'
User = require './structures/userStructure'

# Auth Middleware
validv4 = (uuid) ->
  (uuid.search /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/) isnt -1

auth = (req, res, next) ->
  unless req.signedCookies.login
    res.cookie 'lastUrl', req.url, { expires: moment().endOf('hour').toDate(), signed: true, httpOnly: true }
    res.redirect '/staffLogin'
  else
    if validv4 req.signedCookies.login     
      User.Model.findByLogin req.signedCookies.login, (err, user) ->
        if err then return next err
        unless user then return res.redirect '/login'
        req.user = user  
        next()

module.exports = (app) ->

  # -------------------------------------------------------------
  # Routes

  # ## Gets
  app.get '/', (req, res) ->
    res.sendfile './public/index.html'

  app.get '/days', UserController.userGetDays


  # ## Posts
  app.post '/check', UserController.userCheckDay