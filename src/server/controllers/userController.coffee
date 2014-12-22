bcrypt = require 'bcrypt'
_ = require 'underscore'
mongoose = require 'mongoose'
moment = require 'moment'
uuid = require 'node-uuid'

User = require './../structures/userStructure'

module.exports =
  userRegister: (req, res, next) ->
    registration = req.body.registration
    User.Model.findOne {username: req.body.registration.email}, (e, doc) ->
      if e then return next e
      if doc
        res.json {e: 'emailExists'}
      else
        bcrypt.genSalt 13, (e, salt) ->
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
            console.log doc.username, 'logged in'
            lastLogin = uuid.v4()
            doc.lastLogin = lastLogin
            doc.save()
            res.cookie 'login', lastLogin, { expires: moment().endOf('day').toDate(), signed: true, httpOnly: true }
            if req.signedCookies.lastUrl
              res.redirect req.signedCookies.lastUrl
            else
              res.redirect '/'
          else
            res.json {e: 'loginFail'}
      else
        # res.render 'user not found'
        res.redirect '/userLoginUsereor'

  userLogout: (req, res, next) ->
    res.clearCookie 'login'
    res.redirect '/'