$ ->
  $inputs     = $ '.pure-g input'
  $form       = $ '#welcome-form'
  $firstname  = $ "#first-name"
  $lastname   = $ "#last-name"
  $email      = $ "#email"
  $username   = $ "#username"
  $hint       = $ ".hint"
  $terms      = $ "#terms"
  $button     = $ "#submit-btn"


  checkEntries = ->
    hasValue = ($el) ->
      true  if $el.val() isnt ""

    return (false)  unless hasValue($firstname)
    return (false)  unless hasValue($lastname)
    return (false)  unless hasValue($email)
    return (false)  unless hasValue($username)
    true

  checkEmail = (rslt) ->
    url = "http://flambe.muiral.com:3000/api/utils/checkemail/" + email
    $.get url, (status) ->
      cb status


  checkUserName = (usrName, cb) ->
    url = "http://flambe.muiral.com:3000/api/utils/checkusername/" + usrName
    $.get url, (suggestion) ->
      cb suggestion


  enableSubmit = ->
    if checkEntries() and $terms.is ':checked'
      $button.removeClass "pure-button-disabled"  if $button.hasClass("pure-button-disabled")
    else
      $button.addClass "pure-button-disabled"  unless $button.hasClass("pure-button-disabled")


  $terms.click ->
    if $(this).is(":checked")
      $button.removeClass "pure-button-disabled"  if $button.hasClass("pure-button-disabled") and checkEntries()
    else
      $button.addClass "pure-button-disabled"  unless $button.hasClass("pure-button-disabled")

  $email.on "blur", ->
    $email.mailcheck suggested: (element, suggestion) ->
      unless $hint.html()
        suggestion = "Did you mean <span class='suggestion'>" + "<span class='address'>" + suggestion.address + 
                      "</span>" + "@<a href='#' class='domain'>" + suggestion.domain + "</a></span>?"
        $hint.html(suggestion).fadeIn 150
      else
        # Subsequent errors
        $(".address").html suggestion.address
        $(".domain").html suggestion.domain

  $email.on "focus", ->
    if $hint.is(":visible")
      suggestion = ''
      $hint.fadeOut 150, ->
        $hint.html(suggestion);

  $hint.on 'click', '.domain', ->
    $email.val $(".suggestion").text()
    $hint.fadeOut 200, ->
      $(this).empty()
    false

  $username.on "blur", ->
    checkUserName $username.val(), (suggestion) ->
      console.log suggestion
