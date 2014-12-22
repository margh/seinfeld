require 'coffee-script/register'
express = require 'express'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'

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

app.listen port, ->
  console.log 'listening on', port, 'in', app.settings.env

router(app)