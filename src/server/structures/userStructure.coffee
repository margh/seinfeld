mongoose = require 'mongoose'
moment = require 'moment'

Day = require './dayStructure'

UserSchema = new mongoose.Schema
  email: String
  hash: String
  username: String
  lastLogin: String

UserSchema.statics.findByToken = (token, cb) ->
  @findOne {'lastLogin': token}, cb

UserModel = mongoose.model 'User', UserSchema

module.exports =
  Schema: UserSchema
  Model: UserModel