(function() {
  $(function() {
    var $button, $email, $firstname, $form, $hint, $inputs, $lastname, $terms, $username, checkEmail, checkEntries, checkUserName, enableSubmit;
    $inputs = $('.pure-g input');
    $form = $('#welcome-form');
    $firstname = $("#first-name");
    $lastname = $("#last-name");
    $email = $("#email");
    $username = $("#username");
    $hint = $(".hint");
    $terms = $("#terms");
    $button = $("#submit-btn");
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
    checkEmail = function(rslt) {
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
      if (checkEntries() && $terms.is(':checked')) {
        if ($button.hasClass("pure-button-disabled")) {
          return $button.removeClass("pure-button-disabled");
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
          if (!$hint.html()) {
            suggestion = "Did you mean <span class='suggestion'>" + "<span class='address'>" + suggestion.address + "</span>" + "@<a href='#' class='domain'>" + suggestion.domain + "</a></span>?";
            return $hint.html(suggestion).fadeIn(150);
          } else {
            $(".address").html(suggestion.address);
            return $(".domain").html(suggestion.domain);
          }
        }
      });
    });
    $email.on("focus", function() {
      var suggestion;
      if ($hint.is(":visible")) {
        suggestion = '';
        return $hint.fadeOut(150, function() {
          return $hint.html(suggestion);
        });
      }
    });
    $hint.on('click', '.domain', function() {
      $email.val($(".suggestion").text());
      $hint.fadeOut(200, function() {
        return $(this).empty();
      });
      return false;
    });
    $inputs.each(function(i) {
      return $($inputs[i]).keyup(function() {
        return enableSubmit();
      });
    });
    return $form.on('submit', function(e) {
      e.preventDefault();
      return console.log($(this).serialize());
    });
  });

}).call(this);
