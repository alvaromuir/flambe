# Some basic utils for the webapp

'use strict'
@app = window.app ? {}

define ['jquery'], ($) ->

  app.utils =
    echo: (ping) ->
      return ping

    cycle: (arr, speed, offset, cb) ->
      window.clearInterval window.timer if window.timer
      count = (if offset then offset else 1)
      window.timer = setInterval(->
        if count isnt arr.length
          cb arr[count]
          count += 1
        else
          count = 0
          cb arr[count]
          count += 1
      , speed)
      
    checkUserName: (usrName, cb) ->
      url = document.location.origin + '/api/utils/checkusername/' + usrName
      $.get url, (suggestion) ->
        cb suggestion

    parseLinks: (input) ->
      urlRegex =/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig
      return input.replace urlRegex, (url) -> 
        return '<a href="' + url + '" target="_blank">' + url + '</a>'

    states: ->
      return [
        name: "ALABAMA"
        abbreviation: "AL"
      ,
        name: "ALASKA"
        abbreviation: "AK"
      ,
        name: "AMERICAN SAMOA"
        abbreviation: "AS"
      ,
        name: "ARIZONA"
        abbreviation: "AZ"
      ,
        name: "ARKANSAS"
        abbreviation: "AR"
      ,
        name: "CALIFORNIA"
        abbreviation: "CA"
      ,
        name: "COLORADO"
        abbreviation: "CO"
      ,
        name: "CONNECTICUT"
        abbreviation: "CT"
      ,
        name: "DELAWARE"
        abbreviation: "DE"
      ,
        name: "DISTRICT OF COLUMBIA"
        abbreviation: "DC"
      ,
        name: "FEDERATED STATES OF MICRONESIA"
        abbreviation: "FM"
      ,
        name: "FLORIDA"
        abbreviation: "FL"
      ,
        name: "GEORGIA"
        abbreviation: "GA"
      ,
        name: "GUAM"
        abbreviation: "GU"
      ,
        name: "HAWAII"
        abbreviation: "HI"
      ,
        name: "IDAHO"
        abbreviation: "ID"
      ,
        name: "ILLINOIS"
        abbreviation: "IL"
      ,
        name: "INDIANA"
        abbreviation: "IN"
      ,
        name: "IOWA"
        abbreviation: "IA"
      ,
        name: "KANSAS"
        abbreviation: "KS"
      ,
        name: "KENTUCKY"
        abbreviation: "KY"
      ,
        name: "LOUISIANA"
        abbreviation: "LA"
      ,
        name: "MAINE"
        abbreviation: "ME"
      ,
        name: "MARSHALL ISLANDS"
        abbreviation: "MH"
      ,
        name: "MARYLAND"
        abbreviation: "MD"
      ,
        name: "MASSACHUSETTS"
        abbreviation: "MA"
      ,
        name: "MICHIGAN"
        abbreviation: "MI"
      ,
        name: "MINNESOTA"
        abbreviation: "MN"
      ,
        name: "MISSISSIPPI"
        abbreviation: "MS"
      ,
        name: "MISSOURI"
        abbreviation: "MO"
      ,
        name: "MONTANA"
        abbreviation: "MT"
      ,
        name: "NEBRASKA"
        abbreviation: "NE"
      ,
        name: "NEVADA"
        abbreviation: "NV"
      ,
        name: "NEW HAMPSHIRE"
        abbreviation: "NH"
      ,
        name: "NEW JERSEY"
        abbreviation: "NJ"
      ,
        name: "NEW MEXICO"
        abbreviation: "NM"
      ,
        name: "NEW YORK"
        abbreviation: "NY"
      ,
        name: "NORTH CAROLINA"
        abbreviation: "NC"
      ,
        name: "NORTH DAKOTA"
        abbreviation: "ND"
      ,
        name: "NORTHERN MARIANA ISLANDS"
        abbreviation: "MP"
      ,
        name: "OHIO"
        abbreviation: "OH"
      ,
        name: "OKLAHOMA"
        abbreviation: "OK"
      ,
        name: "OREGON"
        abbreviation: "OR"
      ,
        name: "PALAU"
        abbreviation: "PW"
      ,
        name: "PENNSYLVANIA"
        abbreviation: "PA"
      ,
        name: "PUERTO RICO"
        abbreviation: "PR"
      ,
        name: "RHODE ISLAND"
        abbreviation: "RI"
      ,
        name: "SOUTH CAROLINA"
        abbreviation: "SC"
      ,
        name: "SOUTH DAKOTA"
        abbreviation: "SD"
      ,
        name: "TENNESSEE"
        abbreviation: "TN"
      ,
        name: "TEXAS"
        abbreviation: "TX"
      ,
        name: "UTAH"
        abbreviation: "UT"
      ,
        name: "VERMONT"
        abbreviation: "VT"
      ,
        name: "VIRGIN ISLANDS"
        abbreviation: "VI"
      ,
        name: "VIRGINIA"
        abbreviation: "VA"
      ,
        name: "WASHINGTON"
        abbreviation: "WA"
      ,
        name: "WEST VIRGINIA"
        abbreviation: "WV"
      ,
        name: "WISCONSIN"
        abbreviation: "WI"
      ,
        name: "WYOMING"
        abbreviation: "WY"
      ]

    validateForm: ($form) ->
      console.log 'test'
      return false