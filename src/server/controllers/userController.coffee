bcrypt = require 'bcrypt'
_ = require 'lodash'
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
            doc.lastLoginTime = Date.now()
            doc.save()
            res.cookie 'login', lastLogin, { expires: moment().endOf('day').toDate(), signed: true }
            res.cookie 'username', doc.username, { expires: moment().endOf('day').toDate() }
            res.status(200).send({success: true, username: doc.username})
          else
            res.status(401).send {e: 'loginFail'}
      else
        res.status(401).send {e: 'loginFail'}

  userLogout: (req, res, next) ->
    res.clearCookie 'login'
    res.redirect '/'