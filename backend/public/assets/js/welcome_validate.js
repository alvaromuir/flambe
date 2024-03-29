// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var $button, $currEmail, $currUsrName, $email, $email_warn, $firstname, $form, $hint, $inputs, $lastname, $terms, $username, $usr_warn, checkEmail, checkEntries, checkUserName, enableSubmit, validateEmail, validateUsername;
    $currUsrName = $('#username').val();
    $currEmail = $('#email').val();
    $inputs = $('.pure-g input');
    $form = $('#welcome-form');
    $firstname = $('#first-name');
    $lastname = $('#last-name');
    $email = $('#email');
    $username = $('#username');
    $hint = $('.hint');
    $usr_warn = $('.username_warning');
    $email_warn = $('.email_warning');
    $terms = $('#terms');
    $button = $('#submit-btn');
    checkEntries = function() {
      var hasValue;
      hasValue = function($el) {
        if ($el.val() !== "") {
          return true;
        }
      };
      if (!hasValue($firstname)) {
        return false;
      }
      if (!hasValue($lastname)) {
        return false;
      }
      if (!hasValue($email)) {
        return false;
      }
      if (!hasValue($username)) {
        return false;
      }
      return true;
    };
    checkEmail = function(email, cb) {
      var url;
      url = "http://flambe.muiral.com:3000/api/utils/checkemail/" + email;
      return $.get(url, function(status) {
        return cb(status);
      });
    };
    checkUserName = function(usrName, cb) {
      var url;
      url = "http://flambe.muiral.com:3000/api/utils/checkusername/" + usrName;
      return $.get(url, function(suggestion) {
        return cb(suggestion);
      });
    };
    enableSubmit = function() {
      if (checkEntries()) {
        if ($terms.is(':checked')) {
          if ($button.hasClass("pure-button-disabled")) {
            return $button.removeClass("pure-button-disabled");
          }
        }
      } else {
        if (!$button.hasClass("pure-button-disabled")) {
          return $button.addClass("pure-button-disabled");
        }
      }
    };
    $terms.click(function() {
      if ($(this).is(':checked')) {
        if ($button.hasClass("pure-button-disabled") && checkEntries()) {
          return $button.removeClass("pure-button-disabled");
        }
      } else {
        if (!$button.hasClass("pure-button-disabled")) {
          return $button.addClass("pure-button-disabled");
        }
      }
    });
    $email.on('blur', function() {
      return $email.mailcheck({
        suggested: function(element, suggestion) {
          suggestion = "Did you mean <span class='suggestion'>" + "<span class='address'>" + suggestion.address + "</span>" + "@<a href='#' class='domain'>" + suggestion.domain + "</a></span>?";
          if (!$hint.html()) {
            console.log('ready to fade in');
            return $hint.html(suggestion).fadeIn(150);
          } else {
            $('.address').html(suggestion.address);
            return $('.domain').html(suggestion.domain);
          }
        }
      });
    });
    $email.on("focus", function() {
      var suggestion;
      if ($email_warn.is(":visible")) {
        suggestion = '';
        return $email_warn.fadeOut(150, function() {
          return $email_warn.html(suggestion);
        });
      }
    });
    $hint.on('click', '.domain', function() {
      $email.val($('.suggestion').text());
      $hint.fadeOut(200, function() {
        return $(this).empty();
      });
      return false;
    });
    $username.on("focus", function() {
      var suggestion;
      if ($usr_warn.is(":visible")) {
        suggestion = '';
        return $usr_warn.fadeOut(150, function() {
          return $usr_warn.html(suggestion);
        });
      }
    });
    $usr_warn.on('click', '.username-suggest', function() {
      $username.val($('.username-suggest').text());
      $usr_warn.fadeOut(200, function() {
        return $(this).empty();
      });
      return false;
    });
    $inputs.each(function(i) {
      return $($inputs[i]).keyup(function() {
        return enableSubmit();
      });
    });
    validateEmail = function(requested, suggested, $el, cb) {
      var warning;
      warning = "<div class='warning pure-alert pure-alert-warning'>Sorry! That email address is taken. " + "Do you already have an account? Need <a href=\"reminder\">acount reminder</a>?</div>";
      if (suggested) {
        if (requested !== suggested) {
          return checkEmail(requested, function(rslt) {
            if (rslt === 1) {
              if (!$el.html()) {
                $el.html(warning).fadeIn(150);
              }
              return cb(1);
            } else {
              return cb(0);
            }
          });
        } else {
          return cb(0);
        }
      } else {
        return checkEmail(requested, function(rslt) {
          if (rslt === 1) {
            if (!$el.html()) {
              $el.html(warning).fadeIn(150);
            }
            return cb(1);
          } else {
            return cb(0);
          }
        });
      }
    };
    validateUsername = function(requested, suggested, $el, cb) {
      var warning;
      warning = function(suggestion) {
        return "<div class='warning pure-alert pure-alert-warning'>Sorry! That username is taken. " + "Hows about <a href='#' class='username-suggest'>" + suggestion + "</a>?</div>";
      };
      if (requested !== suggested) {
        return checkUserName(requested, function(suggestion) {
          if (suggestion !== requested) {
            if (!$el.html()) {
              $el.html(warning(suggestion)).fadeIn(150);
              return cb(1);
            }
          } else {
            return cb(0);
          }
        });
      } else {
        return cb(0);
      }
    };
    return $form.on('submit', function(e) {
      e.preventDefault();
      return validateEmail($email.val(), $currEmail, $email_warn, function(rslt) {
        if (rslt !== 0) {
          return;
        }
        return validateUsername($username.val(), $currUsrName, $usr_warn, function(rslt) {
          if (rslt !== 0) {
            return;
          }
          return $form.unbind('submit').submit();
        });
      });
    });
  });

}).call(this);
