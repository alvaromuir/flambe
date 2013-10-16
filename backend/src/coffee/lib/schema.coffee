# DB setup

_str    = require 'underscore.string'
moment  = require 'moment'

module.exports = 
  User:
    model:
      email: String
      name: String
      username: String
      displayName: String
      status: String
      photoUrl: String
      social: {}
      # _id: false
      # id: String
      validated: 
        type: Boolean
        default: false
      verified: 
        type: Boolean
        default: false
      createdOn: 
        type: Date
        default: moment()
      lastUpdated:
        type: Date

    methods: {}
    validators: {}
    virtuals: {}
    
    hooks:
      pre:
        save: (next) ->
          this.createdOn = moment() unless this.createdOn
          next()

        # validate: (next) ->
        #   day 	= moment().format 'MM[.]DD[.]YYYY'
        #   time 	= moment().format 'h:mm:ss a'
        #   next()

      post: {}

    jsonOmit: ['_id']
    webform:
      hide: ['id']
      txtArea: []
      date: []
      check: []
      radio: []
      select: []

  Post:
    model:
      userId: String
      title: String
      primaryPhotoURL: String
      blurb: String
      details: String
      addlPhotosAndDetails: {}
      publishedAt:
        type: Date
        default: Date.now
      # _id: false
      # id: String
      createdOn: 
        type: Date
      lastUpdated:
        type: Date

    methods: {}
    validators: {}
    virtuals: {}
    
    hooks:
      pre: {}
        # save: (next) ->
        #   this.id = _str.slugify this.title unless this.id
        #   next()

        # validate: (next) ->
        #   day   = moment().format 'MM[.]DD[.]YYYY'
        #   time  = moment().format 'h:mm:ss a'
        #   next()

      post: {}

    jsonOmit: ['_id']
    webform:
      hide: ['id']
      txtArea: []
      date: []
      check: []
      radio: []
      select: []