mongoose = require 'mongoose'
moment = require 'moment'
ObjectId = mongoose.Schema.ObjectId

EntrySchema = new mongoose.Schema
  userId: {type: ObjectId, index: true}
  dateString: String
  checked: Boolean
  notes: [String]

EntryModel = mongoose.model 'Entry', EntrySchema

module.exports = EntryModel