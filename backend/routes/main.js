// Generated by CoffeeScript 1.6.3
(function() {
  var User, crud, utils;

  utils = require('../lib/tools');

  crud = require('../lib/crud');

  User = crud.User;

  exports.index = function(req, res) {
    if (req.loggedIn) {
      if (!req.user.completedBasicProfile) {
        res.redirect('/welcome');
        return;
      }
    }
    return res.render('index', {
      title: 'flambé'
    });
  };

  exports.login = function(req, res) {
    var userData;
    if (req.loggedIn) {
      if (!req.user.completedBasicProfile) {
        res.redirect('/welcome');
        return;
      } else {
        userData = req.user;
        res.redirect('/chef/' + req.user.userName);
      }
    }
    return res.render('login', {
      title: 'login | flambé'
    });
  };

  exports.welcome = function(req, res) {
    var userData;
    if (req.loggedIn) {
      userData = req.user;
      if (userData.completedBasicProfile) {
        return res.redirect('/chef/' + req.user.userName);
      } else {
        return res.render('welcome', {
          title: 'Welcome flambé, req.user.displayName | flambé'
        });
      }
    } else {
      return res.redirect('/');
    }
  };

  exports.acctSetup = function(req, res) {
    var updates, userId;
    userId = req.params.id;
    updates = req.body;
    updates.completedBasicProfile = true;
    updates.lastUpdated = moment();
    updates.displayName = updates.firstName + ' ' + updates.lastName;
    return User.updateById(userId, updates, function(err, rslt) {
      if (err) {
        res.send(err);
      }
      return res.redirect('/');
    });
  };

}).call(this);