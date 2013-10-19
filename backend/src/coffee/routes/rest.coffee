# RESTFul Routes

crud = require ('../lib/crud')

User = crud.User

exports.users = (req, res) ->
  User.read {}, (err, rslts) ->
    res.jsonp(err) if err
    res.jsonp rslts
    next()

exports.user = (req, res) ->
  User.readById req.params.id, (err, rslts) ->
    res.jsonp(err) if err
    res.jsonp rslts

exports.userByUserName = (req, res) ->
  User.readOne userName: req.params.username, (err, rslts) ->
    res.jsonp(err) if err
    res.jsonp rslts

exports.checkUserName = (req, res) ->
  User.suggestUserName req.params.username, (suggestion) ->
    res.jsonp suggestion

exports.checkEmailExists = (req, res) ->
  User.checkExistingEmail req.params.email, (suggestion) ->
    res.jsonp suggestion