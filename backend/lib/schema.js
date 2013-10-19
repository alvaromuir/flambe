// Generated by CoffeeScript 1.6.3
(function() {
  var moment, _str;

  _str = require('underscore.string');

  moment = require('moment');

  module.exports = {
    User: {
      model: {
        email: String,
        name: String,
        userName: String,
        displayName: String,
        status: String,
        photoUrl: String,
        website: String,
        aboutMe: String,
        social: {},
        completedBasicProfile: {
          type: Boolean,
          "default": false
        },
        validated: {
          type: Boolean,
          "default": false
        },
        verified: {
          type: Boolean,
          "default": false
        },
        createdOn: {
          type: Date,
          "default": moment()
        },
        lastUpdated: {
          type: Date
        }
      },
      methods: {},
      validators: {},
      virtuals: {},
      hooks: {
        pre: {
          save: function(next) {
            if (!this.createdOn) {
              this.createdOn = moment();
            }
            return next();
          }
        },
        post: {}
      },
      jsonOmit: ['_id'],
      webform: {
        hide: ['id'],
        txtArea: [],
        date: [],
        check: [],
        radio: [],
        select: []
      }
    },
    Post: {
      model: {
        userId: String,
        title: String,
        primaryPhotoURL: String,
        blurb: String,
        details: String,
        addlPhotosAndDetails: {},
        publishedAt: {
          type: Date,
          "default": Date.now
        },
        createdOn: {
          type: Date
        },
        lastUpdated: {
          type: Date
        }
      },
      methods: {},
      validators: {},
      virtuals: {},
      hooks: {
        pre: {},
        post: {}
      },
      jsonOmit: ['_id'],
      webform: {
        hide: ['id'],
        txtArea: [],
        date: [],
        check: [],
        radio: [],
        select: []
      }
    }
  };

}).call(this);
