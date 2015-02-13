Entry = require './../structures/entryStructure'

module.exports =
  entryEnter: (req, res, next) ->
    entry = req.body
    console.log entry
    Entry.findOneAndUpdate {userId: req.user.id, dateString: entry.dateString}, entry, {upsert: true}, (e, entry) ->
      if e then return next(e)
      res.status 201
      res.json entry

  entryGet: (req, res, next) ->
    if e then return next(e)
    Entry.findOne {userId: req.user.id, dateString: req.entry.dateString}, (e, entry) ->
      if e then return next(e)
      res.json entry

  entryGetAll: (req, res, next) ->
    Entry.find {userId: req.user.id}, (e, entries) ->
      if e then return next(e)
      res.json entries