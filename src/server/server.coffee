require 'coffee-script/register'
express = require 'express'

port = process.env.PORT or 40080

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