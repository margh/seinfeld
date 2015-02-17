require 'coffee-script/register'
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
mongoose = require 'mongoose'
uuid = require 'node-uuid'
swig = require 'swig'

router = require './router'

dbPath = process.env.MONGOLAB_URI
signSecret = process.env.SIGN_SECRET

# -------------------------------------------------------------
# DB
mongoose.connect dbPath, (e) ->
  if e then return console.error e
  console.log 'connected to db'

# -------------------------------------------------------------
# Express
port = process.env.PORT or 40080
app = express()
  .use express.static "./public/"
  .use bodyParser.json()
  .use cookieParser signSecret or uuid.v4()
  .engine 'html', swig.renderFile
  .set 'view engine', 'html'
  .set 'views', __dirname + '/views'

app.listen port, ->
  console.log 'listening on', port, 'in', app.settings.env

router(app)