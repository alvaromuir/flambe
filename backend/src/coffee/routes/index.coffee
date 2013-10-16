exports.index = (req, res) ->
  if req.loggedIn
    userData = req.user

    res.render 'index', 
      title: 'flambé'
      greetingName: userData.displayName.split(' ')[0]
      displayName: userData.displayName
      avatar: userData.photoUrl

  else
    res.render 'index', 
      title: 'flambé'


exports.login = (req, res) ->
    res.render 'login', 
      title: 'flambé'