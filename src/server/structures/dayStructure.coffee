mongoose = require 'mongoose'
moment = require 'moment'

DaySchema = new mongoose.Schema
  dateString: String
  notes: [String]

DayModel = mongoose.model 'Day', DaySchema

module.exports =
  Schema: DaySchema
  Model: DayModel