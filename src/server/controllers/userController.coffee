bcrypt = require 'bcrypt'
_ = require 'underscore'
mongoose = require 'mongoose'
moment = require 'moment'
uuid = require 'node-uuid'

User = require './../structures/userStructure'

module.exports =
  userGetDays: (req, res, next) ->
    User.Model.findOne {username: 'nathan'}, (e, n) ->
      res.json n.days

  userCheckDay: (req, res, next) ->
    User.Model.findOne {username: 'nathan'}, (e, n) ->
      n.days.push req.body.day
      n.save (e, saved) ->
        console.log e, saved
        res.send 'success'

  userCreate: (req, res, next) ->
    user = req.body.user
    User.Model.findOne {username: req.body.user.username}, (e, doc) ->
      if e then return next e
      if doc
        res.json {e: 'usernameExists'}
      else
        bcrypt.genSalt 10, (e, salt) ->
          bcrypt.hash user.password, salt, (e, hash) ->
            user.hash = hash
            createdUser = new User.Model user
            createdUser.save (e, doc) ->
              if e then return next(e)
              res.redirect '/'

  userLogin: (req, res, next) ->
    res.clearCookie 'login'
    login = req.body.login
    User.Model.findOne {username: login.username}, (e, doc) ->
      if e then return next(e)
      if doc
        bcrypt.compare login.password, doc.hash, (e, match) ->
          if match
            # res.render 'login success'
            console.log 'login success'
            lastLogin = uuid.v4()
            doc.lastLogin = lastLogin
            doc.save()
            res.cookie 'login', lastLogin, { expires: moment().endOf('day').toDate(), signed: true, httpOnly: true }
            if req.signedCookies.lastUrl
              res.redirect req.signedCookies.lastUrl
            else
              res.redirect '/'
          else
            # res.render 'login fail'
            res.json {e: 'loginFail'}
      else
        # res.render 'user not found'
        res.redirect '/userLoginUsereor'

  userLogout: (req, res, next) ->
    res.clearCookie 'login'
    res.redirect '/'