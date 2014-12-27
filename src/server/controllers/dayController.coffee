_ = require 'underscore'

Day = require './../structures/dayStructure'

module.exports =
  dayEnter: (req, res, next) ->
    entry = req.body
    console.log entry
    Day.findOneAndUpdate {userId: req.user.id, dateString: entry.dateString}, entry, {upsert: true}, (e, day) ->
      if e then return next(e)
      res.sendStatus 201

  dayGet: (req, res, next) ->
    if e then return next(e)
    Day.findOne {userId: req.user.id, dateString: req.day.dateString}, (e, day) ->
      if e then return next(e)
      res.json day

  dayGetAll: (req, res, next) ->
    Day.find {userId: req.user.id}, (e, days) ->
      if e then return next(e)
      res.json days