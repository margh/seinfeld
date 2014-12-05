mongoose = require 'mongoose'
Schema = mongoose.Schema

DaySchema = new Schema
  checked: Boolean
  dateString: String

module.exports = DaySchema