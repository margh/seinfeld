_ = require 'underscore'

Day = require './../structures/dayStructure'

module.exports =
  dayEnter: (req, res, next) ->
    entry = req.day
    Day.findOneAndUpdate {userId: req.user.id}

  dayGet: (req, res, next) ->
    if e then return next(e)
    Day.Model.findOne {userId: req.user.id, dateString: req.day.dateString}, (e, day) ->
      if e then return next(e)
      res.json day

  dayGetAll: (req, res, next) ->
    Day.Model.find {userId: req.user.id}, (e, days) ->
      if e then return next(e)
      res.json days