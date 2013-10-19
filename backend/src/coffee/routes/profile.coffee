# Profile routes
utils   = require '../lib/tools'
crud    = require '../lib/crud'

User    = crud.User

checkBasicProfile = (req) ->
  if req.loggedIn
    userData  = req.user
    res.redirect '/' unless userData.completedBasicProfile
    return

getUserAttributes = (usrData) ->
  renderObj = {}
  renderObj.title              = usrData.name + ' | flambé'
  renderObj.profileName        = usrData.name
  renderObj.profileUserName    = usrData.userName
  renderObj.profileDisplayName = usrData.displayName
  renderObj.profileAvatar      = usrData.photoUrl
  renderObj.profileStatus      = usrData.status
  renderObj.profileTwitter     = usrData.social.twitter.url if usrData.social.twitter
  renderObj.profileFacebook    = usrData.social.facebook.url if usrData.social.facebook
  renderObj.profileLinkedIn    = usrData.social.linkedin.url if usrData.social.linkedin
  renderObj.profileWebsite     = usrData.website.url if usrData.website

  renderObj.lastPostDate       = utils.fromNow 'October 4, 2013'

  renderObj

exports.index = (req, res) ->
  checkBasicProfile(req, res)

  User.readOne userName:req.params.username, (err, rslt) ->
    res err if err
    if rslt
      res.render 'profile', getUserAttributes rslt
    else 
      res.send 'Error page: chef not found. Go <a href="/">home</a>.'




exports.byId = (req, res) ->
  checkBasicProfile(req, res)
  
  User.readById req.params.id, (err, rslt) ->
    res err if err
    if rslt
      res.render 'profile', getUserAttributes rslt
    else 
      res.send 'Error page: chef not found. Go <a href="/">home</a>.'