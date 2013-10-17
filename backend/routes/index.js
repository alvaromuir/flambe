// Generated by CoffeeScript 1.6.3
(function() {
  exports.index = function(req, res) {
    var userData;
    if (req.loggedIn) {
      userData = req.user;
      return res.render('index', {
        title: 'flambé',
        greetingName: userData.displayName.split(' ')[0],
        displayName: userData.displayName,
        userName: userData.userName,
        avatar: userData.photoUrl
      });
    } else {
      return res.render('index', {
        title: 'flambé'
      });
    }
  };

  exports.login = function(req, res) {
    return res.render('login', {
      title: 'login | flambé'
    });
  };

  exports.welcome = function(req, res) {
    var userData;
    if (req.loggedIn) {
      userData = req.user;
      return res.render('welcome', {
        title: 'Welcome flambé',
        greetingName: userData.displayName.split(' ')[0],
        lastName: userData.displayName.split(' ')[1],
        userName: userData.userName,
        avatar: userData.photoUrl
      });
    } else {
      return res.render('welcome', {
        title: 'flambé'
      });
    }
  };

}).call(this);
