mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost:27017', (e) ->
  if e then return console.error e
  console.log 'connected to db'


User = require './structures/userStructure'

nathan = {
  username: 'nathan'
}

n = new User.Model nathan
n.save (e, nate) ->
  console.log e
  console.log nate