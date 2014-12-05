require 'coffee-script/register'
express = require 'express'
mongoose = require 'mongoose'

twix = require 'twix'
moment = require 'moment'

port = process.env.PORT or 40080

mongoose.connect 'mongodb://localhost:27017', (e) ->
  if e then return console.error e
  console.log 'connected to db'

DaySchema = require './schemas/daySchema'

Day = mongoose.model 'days', DaySchema

server = express()
  # Could sub this out for an nginx one with better caching.
  .use express.static "./public/"

server.listen port, ->
  console.log 'listening on', port, 'in', server.settings.env

# ---------------------------------------------------------------------
# ##
# Routes
# ##

# ## Gets
server.get '/', (req, res) ->
  res.sendfile './public/index.html'


server.get '/days', (req, res, next) ->
  Day.find {}, (e, docs) ->
    if e then return console.error e
    res.json docs
