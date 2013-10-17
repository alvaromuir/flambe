# Everyauth Schemas
util  = require 'util'

keys  = require './keys'
crud  = require './crud'

User  = crud.User


module.exports = 

  init: (everyauth) ->

    # Attach returned user data to request for views
    everyauth.everymodule.findUserById (id, cb) ->
      User.readById id, (err, rslt) ->
        cb err, rslt
    everyauth.everymodule.userPkey('_id');

    # Twitter auth
    everyauth.twitter.consumerKey keys.twitter.consumerKey
    everyauth.twitter.consumerSecret keys.twitter.consumerSecret
    everyauth.twitter.findOrCreateUser (session, accessToken, accessTokenSecret, data) ->
      promise = this.Promise()
      User.findOrCreateUserByTwitterData data, promise
      promise
    everyauth.twitter.redirectPath '/welcome'

    # Facebook auth
    everyauth.facebook.appId keys.facebook.appId
    everyauth.facebook.appSecret keys.facebook.appSecret
    # everyauth.facebook.handleAuthCallbackError (res, res) ->
    #   # ToDo:
    #   # respond when user denies accss to app
    #   return
    everyauth.facebook.findOrCreateUser (session, accessToken, accessTokExtra, data) ->
      promise = this.Promise()
      User.findOrCreateUserByFacebookData data, promise
      promise
    everyauth.facebook.redirectPath '/welcome'

    # LinkedIn auth
    everyauth.linkedin.consumerKey keys.linkedin.consumerKey
    everyauth.linkedin.consumerSecret keys.linkedin.consumerSecret
    everyauth.linkedin.findOrCreateUser (session, accessToken, accessTokenSecret, data) ->
      promise = this.Promise()
      User.findOrCreateUserByLinkedinData data, promise
      promise
    everyauth.linkedin.redirectPath '/welcome'

