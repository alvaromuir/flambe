# Routes

utils   = require '../lib/tools'
crud    = require '../lib/crud'

User    = crud.User

# redirect user back to welcome page if they havent provided an email address

exports.index = (req, res) ->
  if req.loggedIn
    if not req.user.completedBasicProfile
      res.redirect '/welcome'
      return

  res.render 'index', 
    title: 'flambé'


exports.login = (req, res) ->
  if req.loggedIn
    if not req.user.completedBasicProfile
      res.redirect '/welcome'
      return
    else
      userData  = req.user
      res.redirect '/chef/' + req.user.userName

  res.render 'login', 
    title: 'login | flambé'
      

exports.welcome = (req, res) ->
  if req.loggedIn
    userData  = req.user
    if userData.completedBasicProfile
      res.redirect '/chef/' + req.user.userName
    else
      res.render 'welcome', 
        title: 'Welcome flambé'
  else
    res.redirect '/'


exports.acctSetup = (req, res) ->
  userId  = req.params.id
  updates = req.body
  
  updates.completedBasicProfile = true
  updates.lastUpdated = moment()
  updates.displayName = updates.firstName + ' ' + updates.lastName

  User.updateById userId, updates, (err, rslt) ->
    res.send err if err
    res.redirect '/'