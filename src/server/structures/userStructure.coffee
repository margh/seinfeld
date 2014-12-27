mongoose = require 'mongoose'
moment = require 'moment'

Day = require './dayStructure'

UserSchema = new mongoose.Schema
  username: String
  email: String
  hash: String
  lastLogin: String

UserSchema.statics.findByToken = (token, cb) ->
  @findOne {'lastLogin': token}, cb

UserModel = mongoose.model 'User', UserSchema

module.exports = UserModel