# General controller

exports.index = (req, res) ->
  if req.loggedIn
    userData = req.user

    res.render 'index', 
      title: 'flambé'
      greetingName: userData.displayName.split(' ')[0]
      displayName: userData.displayName
      userName: userData.userName
      avatar: userData.photoUrl

  else
    res.render 'index', 
      title: 'flambé'


exports.login = (req, res) ->
    res.render 'login', 
      title: 'login | flambé'

exports.welcome = (req, res) ->
  if req.loggedIn
    userData  = req.user

    res.render 'welcome', 
      title: 'Welcome flambé'
      greetingName: userData.displayName.split(' ')[0]
      lastName: userData.displayName.split(' ')[1]
      userName: userData.userName
      avatar: userData.photoUrl

  else
    res.render 'welcome', 
      title: 'flambé'