_ = require 'underscore'
mongoose = require 'mongoose'

Day = require './../structures/dayStructure'

module.exports =
  dayEnter: (req, res, next) ->
    entry = req.day

    Day.findOneAndUpdate {userId: req.user.id}