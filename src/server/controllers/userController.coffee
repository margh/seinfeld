bcrypt = require 'bcrypt'
_ = require 'underscore'
mongoose = require 'mongoose'
moment = require 'moment'
uuid = require 'node-uuid'

User = require './../structures/userStructure'

module.exports =
  userRegister: (req, res, next) ->
    user = req.body
    User.findOne {email: req.body.email}, (e, doc) ->
      if e then return next e
      if doc
        res.status(400).send {e: 'userExists'}
      else
        bcrypt.genSalt 13, (e, salt) ->
          bcrypt.hash user.password, salt, (e, hash) ->
            user.hash = hash
            createdUser = new User user
            createdUser.save (e, doc) ->
              if e then return next(e)
              res.sendStatus 201

  userLogin: (req, res, next) ->
    res.clearCookie 'login'
    login = req.body
    User.findOne {email: login.email}, (e, doc) ->
      if e then return next(e)
      if doc
        bcrypt.compare login.password, doc.hash, (e, match) ->
          if match
            console.log doc.email, 'logged in'
            lastLogin = uuid.v4()
            doc.lastLogin = lastLogin
            doc.save()
            res.cookie 'login', lastLogin, { expires: moment().endOf('day').toDate(), signed: true }
            if req.signedCookies.lastUrl
              res.redirect req.signedCookies.lastUrl
            else
              res.sendStatus 200
          else
            res.status(401).send {e: 'loginFail'}
      else
        res.status(401).send {e: 'loginFail'}

  userLogout: (req, res, next) ->
    res.clearCookie 'login'
    res.redirect '/'