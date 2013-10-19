$ ->
  $currUsrName  = $('#username').val()
  $currEmail    = $('#email').val()
  $inputs       = $ '.pure-g input'
  $form         = $ '#welcome-form'
  $firstname    = $ '#first-name'
  $lastname     = $ '#last-name'
  $email        = $ '#email'
  $username     = $ '#username'
  $hint         = $ '.hint'
  $usr_warn     = $ '.username_warning'
  $email_warn   = $ '.email_warning'
  $terms        = $ '#terms'
  $button       = $ '#submit-btn'

  checkEntries = ->
    hasValue = ($el) ->
      true unless $el.val() is ""

    return false unless hasValue $firstname
    return false unless hasValue $lastname
    return false unless hasValue $email
    return false unless hasValue $username
    true

  checkEmail = (email, cb) ->
    url = "http://flambe.muiral.com:3000/api/utils/checkemail/" + email
    $.get url, (status) ->
      cb status

  checkUserName = (usrName, cb) ->
    url = "http://flambe.muiral.com:3000/api/utils/checkusername/" + usrName
    $.get url, (suggestion) ->
      cb suggestion

  enableSubmit = ->
    if checkEntries()
      if $terms.is ':checked'
        $button.removeClass "pure-button-disabled"  if $button.hasClass("pure-button-disabled")
    else
      $button.addClass "pure-button-disabled"  unless $button.hasClass("pure-button-disabled")


  $terms.click ->
    if $(this).is(':checked')
      $button.removeClass "pure-button-disabled"  if $button.hasClass("pure-button-disabled") and checkEntries()
    else
      $button.addClass "pure-button-disabled"  unless $button.hasClass("pure-button-disabled")

  $email.on 'blur', ->
    $email.mailcheck suggested: (element, suggestion) ->
      suggestion = "Did you mean <span class='suggestion'>" + "<span class='address'>" + suggestion.address + 
                      "</span>" + "@<a href='#' class='domain'>" + suggestion.domain + "</a></span>?"

      unless $hint.html()
        console.log 'ready to fade in'
        $hint.html(suggestion).fadeIn 150
      else
        $('.address').html suggestion.address
        $('.domain').html suggestion.domain


  $email.on "focus", ->
    if $email_warn.is(":visible")
      suggestion = ''
      $email_warn.fadeOut 150, ->
        $email_warn.html(suggestion);

  $hint.on 'click', '.domain', ->
    $email.val $('.suggestion').text()
    $hint.fadeOut 200, ->
      $(this).empty()
    false

  $username.on "focus", ->
    if $usr_warn.is(":visible")
      suggestion = ''
      $usr_warn.fadeOut 150, ->
        $usr_warn.html(suggestion);

  $usr_warn.on 'click', '.username-suggest', ->
    $username.val $('.username-suggest').text()
    $usr_warn.fadeOut 200, ->
      $(this).empty()
    false
 
  $inputs.each (i) ->
    $($inputs[i]).keyup ->
      enableSubmit()


  validateEmail = (requested, suggested, $el, cb) ->

    warning = "<div class='warning pure-alert pure-alert-warning'>Sorry! That email address is taken. " +
            "Do you already have an account? Need <a href=\"reminder\">acount reminder</a>?</div>"

    if suggested
      if requested isnt suggested
        checkEmail requested, (rslt) ->
          if rslt is 1
            unless $el.html()
              $el.html(warning).fadeIn 150
            cb 1
          else
            cb 0
      else
        cb 0
    else
      checkEmail requested, (rslt) ->
        if rslt is 1
          unless $el.html()
            $el.html(warning).fadeIn 150
          cb 1
        else
          cb 0

  validateUsername = (requested, suggested, $el, cb) ->
    warning = (suggestion) ->
      "<div class='warning pure-alert pure-alert-warning'>Sorry! That username is taken. " +
      "Hows about <a href='#' class='username-suggest'>"+ 
      suggestion + "</a>?</div>"

    if requested isnt suggested
      checkUserName requested, (suggestion) ->
        if suggestion isnt requested  # username suggested by server doesnt match username text field
          unless $el.html()
            $el.html(warning(suggestion)).fadeIn 150
            cb 1
        else
          cb 0
    else
      cb 0


  $form.on 'submit', (e) ->
    e.preventDefault()

    validateEmail $email.val(), $currEmail, $email_warn, (rslt) ->
      return unless rslt is 0
      validateUsername $username.val(), $currUsrName, $usr_warn, (rslt) ->
        return unless rslt is 0
        $form.unbind('submit').submit()