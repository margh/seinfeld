require 'coffee-script/register'
express = require 'express'
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
  # Could sub this out for an nginx one with better caching.
  .use express.static "./public/"

app.listen port, ->
  console.log 'listening on', port, 'in', app.settings.env

router(app)