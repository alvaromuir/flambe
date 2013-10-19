(function() {
  'use strict';
  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['jquery'], function($) {
    return app.utils = {
      echo: function(ping) {
        return ping;
      },
      cycle: function(arr, speed, offset, cb) {
        var count;
        if (window.timer) {
          window.clearInterval(window.timer);
        }
        count = (offset ? offset : 1);
        return window.timer = setInterval(function() {
          if (count !== arr.length) {
            cb(arr[count]);
            return count += 1;
          } else {
            count = 0;
            cb(arr[count]);
            return count += 1;
          }
        }, speed);
      },
      checkUserName: function(usrName, cb) {
        var url;
        url = document.location.origin + '/api/utils/checkusername/' + usrName;
        return $.get(url, function(suggestion) {
          return cb(suggestion);
        });
      },
      parseLinks: function(input) {
        var urlRegex;
        urlRegex = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
        return input.replace(urlRegex, function(url) {
          return '<a href="' + url + '" target="_blank">' + url + '</a>';
        });
      },
      states: function() {
        return [
          {
            name: "ALABAMA",
            abbreviation: "AL"
          }, {
            name: "ALASKA",
            abbreviation: "AK"
          }, {
            name: "AMERICAN SAMOA",
            abbreviation: "AS"
          }, {
            name: "ARIZONA",
            abbreviation: "AZ"
          }, {
            name: "ARKANSAS",
            abbreviation: "AR"
          }, {
            name: "CALIFORNIA",
            abbreviation: "CA"
          }, {
            name: "COLORADO",
            abbreviation: "CO"
          }, {
            name: "CONNECTICUT",
            abbreviation: "CT"
          }, {
            name: "DELAWARE",
            abbreviation: "DE"
          }, {
            name: "DISTRICT OF COLUMBIA",
            abbreviation: "DC"
          }, {
            name: "FEDERATED STATES OF MICRONESIA",
            abbreviation: "FM"
          }, {
            name: "FLORIDA",
            abbreviation: "FL"
          }, {
            name: "GEORGIA",
            abbreviation: "GA"
          }, {
            name: "GUAM",
            abbreviation: "GU"
          }, {
            name: "HAWAII",
            abbreviation: "HI"
          }, {
            name: "IDAHO",
            abbreviation: "ID"
          }, {
            name: "ILLINOIS",
            abbreviation: "IL"
          }, {
            name: "INDIANA",
            abbreviation: "IN"
          }, {
            name: "IOWA",
            abbreviation: "IA"
          }, {
            name: "KANSAS",
            abbreviation: "KS"
          }, {
            name: "KENTUCKY",
            abbreviation: "KY"
          }, {
            name: "LOUISIANA",
            abbreviation: "LA"
          }, {
            name: "MAINE",
            abbreviation: "ME"
          }, {
            name: "MARSHALL ISLANDS",
            abbreviation: "MH"
          }, {
            name: "MARYLAND",
            abbreviation: "MD"
          }, {
            name: "MASSACHUSETTS",
            abbreviation: "MA"
          }, {
            name: "MICHIGAN",
            abbreviation: "MI"
          }, {
            name: "MINNESOTA",
            abbreviation: "MN"
          }, {
            name: "MISSISSIPPI",
            abbreviation: "MS"
          }, {
            name: "MISSOURI",
            abbreviation: "MO"
          }, {
            name: "MONTANA",
            abbreviation: "MT"
          }, {
            name: "NEBRASKA",
            abbreviation: "NE"
          }, {
            name: "NEVADA",
            abbreviation: "NV"
          }, {
            name: "NEW HAMPSHIRE",
            abbreviation: "NH"
          }, {
            name: "NEW JERSEY",
            abbreviation: "NJ"
          }, {
            name: "NEW MEXICO",
            abbreviation: "NM"
          }, {
            name: "NEW YORK",
            abbreviation: "NY"
          }, {
            name: "NORTH CAROLINA",
            abbreviation: "NC"
          }, {
            name: "NORTH DAKOTA",
            abbreviation: "ND"
          }, {
            name: "NORTHERN MARIANA ISLANDS",
            abbreviation: "MP"
          }, {
            name: "OHIO",
            abbreviation: "OH"
          }, {
            name: "OKLAHOMA",
            abbreviation: "OK"
          }, {
            name: "OREGON",
            abbreviation: "OR"
          }, {
            name: "PALAU",
            abbreviation: "PW"
          }, {
            name: "PENNSYLVANIA",
            abbreviation: "PA"
          }, {
            name: "PUERTO RICO",
            abbreviation: "PR"
          }, {
            name: "RHODE ISLAND",
            abbreviation: "RI"
          }, {
            name: "SOUTH CAROLINA",
            abbreviation: "SC"
          }, {
            name: "SOUTH DAKOTA",
            abbreviation: "SD"
          }, {
            name: "TENNESSEE",
            abbreviation: "TN"
          }, {
            name: "TEXAS",
            abbreviation: "TX"
          }, {
            name: "UTAH",
            abbreviation: "UT"
          }, {
            name: "VERMONT",
            abbreviation: "VT"
          }, {
            name: "VIRGIN ISLANDS",
            abbreviation: "VI"
          }, {
            name: "VIRGINIA",
            abbreviation: "VA"
          }, {
            name: "WASHINGTON",
            abbreviation: "WA"
          }, {
            name: "WEST VIRGINIA",
            abbreviation: "WV"
          }, {
            name: "WISCONSIN",
            abbreviation: "WI"
          }, {
            name: "WYOMING",
            abbreviation: "WY"
          }
        ];
      },
      validateForm: function($form) {
        console.log('test');
        return false;
      }
    };
  });

}).call(this);
