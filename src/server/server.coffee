require 'coffee-script/register'
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
mongoose = require 'mongoose'
uuid = require 'node-uuid'

router = require './router'

# -------------------------------------------------------------
# DB
mongoose.connect 'mongodb://localhost:27017', (e) ->
  if e then return console.error e
  console.log 'connected to db'

# -------------------------------------------------------------
# Express
port = process.env.PORT or 40080
app = express()
  .use express.static "./public/"
  .use bodyParser.json()
  # .use cookieParser uuid.v4()
  .use cookieParser 'saaaah secret'
 
app.listen port, ->
  console.log 'listening on', port, 'in', app.settings.env

router(app)