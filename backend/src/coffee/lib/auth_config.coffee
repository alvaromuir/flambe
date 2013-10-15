# Everyauth Schemas
util  	= require 'util'
keys	= require './keys'

module.exports =
  init: (auth) ->
    # auth.twitter.consumerKey keys.twitter.consumerKey
    # auth.twitter.consumerSecret keys.twitter.consumerSecret
    # auth.twitter.findOrCreateUser (session, accessToken, accessTokenSecret, userData) ->
    #   # console.log util.inspect(userData)
    #   promise = new Promise
    #   promise