mongoose = require 'mongoose'
moment = require 'moment'

User = require './structures/userStructure'

UserController = require './controllers/userController'
EntryController = require './controllers/entryController'

# 30 days
loginExpireTime = 2592000000

# Auth Middleware
validv4 = (uuid) ->
  (uuid.search /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/) isnt -1

auth = (req, res, next) ->
  unless req.signedCookies.login
    res.status(401).send {e: 'unauthorized'}
  else
    if validv4 req.signedCookies.login
      User.findByToken req.signedCookies.login, (err, user) ->
        if err then return next err
        if Date.now() - user.lastLoginTime > loginExpireTime
          return res.status(401).send {e: 'loginExpired'}
        req.user = user
        next()

module.exports = (app) ->

  # -------------------------------------------------------------
  # Routes

  # ## GETs
  app.get '/', (req, res) ->
    res.sendfile './public/index.html'

  app.get '/entries/all', auth, EntryController.entryGetAll

  app.get '/entries/:dateString', auth, EntryController.entryGet

  app.post '/entries/:dateString', auth, EntryController.entryEnter


  # ## PUTs

  # Register
  app.post '/users', UserController.userRegister

  # Login
  app.post '/login', UserController.userLogin

  # app.post '/enter/:dateString', UserController.userEnterDay

  # ## ERROR HANDLING
  app.use (e, req, res, next) ->
    console.error e, e.stack
    res.sendStatus 500


# POST /logout   // destroys session and redirects to /
# GET  /login    // gets the webpage that has the login form
# POST /login    // authenticates credentials against database and either redirects home with a new session or redirects back to /login
# GET  /register // gets the webpage that has the registration form
# POST /register // records the entered information into database as a new /user/xxx
# GET  /user/xxx // gets and renders current user data in a profile view
# POST /user/xxx // updates new information about user