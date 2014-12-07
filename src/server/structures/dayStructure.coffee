mongoose = require 'mongoose'
moment = require 'moment'

DaySchema = new mongoose.Schema
  checked: Boolean
  dateString: String

DayModel = mongoose.model 'Day', DaySchema

module.exports =
  Schema: DaySchema
  Model: DayModel