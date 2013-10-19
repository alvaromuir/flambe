# Users setup

db = require './db_config'
_  = require 'lodash'

User  = db.models.User
Post  = db.models.Post


create = (model, doc, cb) ->
  model.create doc, (err, rslt) ->    
    cb err, rslt

find = (model, criteria, cb) ->
  model.find criteria, (err, rslt) ->    
    cb err, rslt

findById = (model, id, fields, opt, cb) ->
  model.findById id, fields, opt, (err, rslt) ->    
    cb err, rslt

findOne = (model, criteria, fields, opt, cb) ->
  model.findOne criteria, fields, opt, (err, rslt) ->    
    cb err, rslt

update = (model, criteria, updates, opt, cb) ->
  model.update criteria, updates, opt, (err, rsltCount, res) ->
    rslt = 
      total: rsltCount
      response: res
    cb err, rslt

updateById = (model, id, updates, opt, cb) ->
  model.findByIdAndUpdate id, updates, opt, (err, rslt) ->    
    cb err, rslt

updateOne = (model, criteria, updates, opt, cb) ->
  model.findOneAndUpdate criteria, updates, opt, (err, rslt) ->    
    cb err, rslt

remove = (rcrd, criteria, cb) ->
  rcrd.remove criteria, (err) ->
    cb err

removeQuick = (model, criteria) ->
  removeQuery = model.remove criteria
  removeQuery.exec()

removeById = (model, id, opt, cb) ->
  model.findByIdAndRemove id, opt, (err, rslt) ->    
    cb err, rslt

removeOne = (model, criteria, opt, cb) ->
  model.findOneAndRemove criteria, opt, (err, rslt) ->
    cb err, rslt

count = (model, criteria, cb) ->
  model.count criteria, (err, rslt) ->    
    cb err, rslt

checkUserName = (usrName, cb, orig) ->
  User.findOne userName: usrName, null, null, (err, rslt) ->
    if rslt
      orig = usrName
      userName = orig + _.random 1, 9999
      checkUserName userName, cb, orig
    else
      cb usrName

checkEmailExists = (email, cb) ->
  User.findOne email: email, null, null, (err, rslt) ->
    if rslt
      cb 1
    else
      cb 0

# Public methods
module.exports = 
  setup: db
  User: 
    create: (doc, cb) ->
      create User, doc, cb

    read: (criteria, cb) ->
      find User, criteria, cb

    readById: (id, fields, opt, cb) ->
      findById User, id, fields, opt, cb

    readOne: (criteria, fields, opt, cb) ->
      findOne User, criteria, fields, opt, cb

    update: (criteria, updates, opt, cb) ->
      update User, criteria, updates, opt, cb

    updateById: (id, updates, opt, cb) ->
      updateById User, id, updates, opt, cb

    updateOne: (criteria, updates, opt, cb) ->
      updateOne User, criteria, updates, opt, cb

    delete: (rcrd, criteria, cb) ->
      remove rcrd, criteria, cb

    deleteQuick: (criteria) ->
      removeQuick User, criteria

    deleteById: (id, opt, cb) ->
      removeById User, id, opt, cb

    deleteOne: (criteria, opt, cb) ->
      removeOne User, criteria, opt, cb

    # util
    count: (criteria, cb) ->
      count User, criteria, cb

    suggestUserName: (usrName, cb) ->
      checkUserName usrName, cb

    checkExistingEmail: (email, cb) ->
      checkEmailExists email, cb

    # social auth

    findOrCreateUserByTwitterData: (data, promise) ->
      findOne User, 'social.twitter.id_str': data.id_str, (err, rslt) ->
        if err
          promise.fail(err)
        if rslt
          promise.fulfill rslt
        else
          suggUserName = (data.name.split(' ')[0] + data.name.split(' ')[1]).toLowerCase()
          checkUserName suggUserName, (suggestion) ->
            rslt = 
              email: ''
              name: data.name
              userName: suggestion
              displayName: data.name
              status: 'Joined flambé on ' + moment().format('MMM Do, YYYY')
              photoUrl: data.profile_image_url
              website: data.url
              social: 
                twitter:
                  id_str: data.id_str
                  url: 'https://twitter.com/' + data.screen_name
                  avatar: data.profile_image_url

            create User, rslt, (err, rslt) ->
              if err
                promise.fail(err)
              else
                promise.fulfill rslt

    findOrCreateUserByFacebookData: (data, promise) ->
      findOne User, 'social.facebook.id': data.id, (err, rslt) ->
        if err
          promise.fail(err)
        if rslt
          promise.fulfill rslt
        else
          suggUserName = (data.name.split(' ')[0] + data.name.split(' ')[1]).toLowerCase()
          checkUserName suggUserName, (suggestion) ->
            rslt = 
              email: suggUserName + '@facebook.com'
              name: data.name
              userName: suggestion
              displayName: data.name
              status: 'Joined flambé on ' + moment().format('MMM Do, YYYY')
              photoUrl: "https://graph.facebook.com/" + data.id + "/picture?type=square"
              social: 
                facebook:
                  id: data.id
                  url: data.link
                  avatar: "https://graph.facebook.com/" + data.id + "/picture?type=square"

            create User, rslt, (err, rslt) ->
              if err
                promise.fail(err)
              else
                promise.fulfill rslt

    findOrCreateUserByLinkedinData: (data, promise) ->
      findOne User, 'social.linkedin.id': data.id, (err, rslt) ->
        if err
          promise.fail(err)
        if rslt
          promise.fulfill rslt
        else
          suggUserName = (data.firstName + data.lastName).toLowerCase()
          checkUserName suggUserName, (suggestion) ->
            rslt = 
              email: ''
              name: data.firstName + ' ' + data.lastName
              userName: suggestion
              displayName: data.firstName + ' ' + data.lastName
              status: 'Joined flambé on ' + moment().format('MMM Do, YYYY')
              photoUrl: data.pictureUrl
              social: 
                linkedin:
                  id: data.id
                  url: data.publicProfileUrl
                  avatar: data.pictureUrl

            create User, rslt, (err, rslt) ->
              if err
                promise.fail(err)
              else
                promise.fulfill rslt

  Post: {}