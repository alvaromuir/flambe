# General controller

main    = require './main'
details = require './details'
profile = require './profile'
rest	= require './rest'


exports.addRoutes = (app) ->
  app.get '/',        main.index
  app.get '/login',   main.login
  app.get '/welcome', main.welcome
  app.get '/details', details.index
  app.get '/chef/:username', profile.index
  app.get '/user/:id', profile.byId

  # Rest
  app.get '/api/users',     rest.users
  app.get '/api/users/:id', rest.user

  # Rest utils
  app.get '/api/users/by/username/:username',   rest.userByUserName
  app.get '/api/utils/checkusername/:username', rest.checkUserName
  app.get '/api/utils/checkemail/:email',       rest.checkEmailExists

  # Dev testing
  app.put '/acct/setup/:id', main.acctSetup