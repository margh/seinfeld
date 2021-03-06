mongoose = require 'mongoose'
moment = require 'moment'

Entry = require './entryStructure'

UserSchema = new mongoose.Schema
  username: String
  email: String
  hash: String
  lastLogin: String
  lastLoginTime: Date

UserSchema.statics.findByToken = (token, cb) ->
  @findOne {'lastLogin': token}, cb

UserModel = mongoose.model 'User', UserSchema

module.exports = UserModel