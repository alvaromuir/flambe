# Users setup

db = require './db_config'

User  = db.models.User
Post  = db.models.Post


create = (model, doc, cb) ->
  model.create doc, (err, rslt) ->    
    cb err if err
    cb rslt

find = (model, criteria, cb) ->
  model.find criteria, (err, rslt) ->    
    cb err if err
    cb rslt

findById = (model, id, cb) ->
  model.findById id, (err, rslt) ->    
    cb err if err
    cb rslt

findOne = (model, criteria, cb) ->
  model.findOne criteria, (err, rslt) ->    
    cb err if err
    cb rslt

update = (model, criteria, updates, opt, cb) ->
  model.update criteria, updates, opt, (err, rsltCount, res) ->
    cb err if err
    rslt = 
      total: rsltCount
      response: res
    cb rslt

updateByID = (model, id, updates, opt, cb) ->
  model.findByIdAndUpdate id, updates, opt, (err, rslt) ->    
    cb err if err
    cb rslt

updateOne = (model, criteria, updates, opt, cb) ->
  model.findOneAndUpdate criteria, updates, opt, (err, rslt) ->    
    cb err if err
    cb rslt

remove = (rcrd, criteria, cb) ->
  rcrd.remove criteria, (err) ->
    cb err if err

removeQuick = (model, criteria) ->
  removeQuery = model.remove criteria
  removeQuery.exec()

removeByID = (model, id, opt, cb) ->
  model.findByIdAndRemove id, opt, (err, rslt) ->    
    cb err if err
    cb rslt

removeOne = (model, criteria, opt, cb) ->
  model.findOneAndRemove criteria, opt, (err, rslt) ->
    cb err if err
    cb rslt

count = (model, criteria, cb) ->
  model.count criteria, (err, rslt) ->    
    cb err if err
    cb rslt



module.exports = 
  setup: db
  User: 
    create: (doc, cb) ->
      create User, doc, cb

    read: (criteria, cb) ->
      find User, criteria, cb

    readById: (id, cb) ->
      findById User, id, cb

    readOne: (criteria, cb) ->
      findOne User, criteria, cb

    update: (criteria, updates, opt, cb) ->
      update User, criteria, updates, opt, cb

    updateByID: (id, updates, opt, cb) ->
      updateByID User, id, updates, opt, cb

    updateOne: (criteria, updates, opt, cb) ->
      updateOne User, criteria, updates, opt, cb

    delete: (rcrd, criteria, cb) ->
      remove rcrd, criteria, cb

    deleteQuick: (criteria) ->
      remove User, criteria

    deleteByID: (id, opt, cb) ->
      removeByID User, id, opt, cb

    deleteOne: (criteria, opt, cb) ->
      removeOne User, criteria, opt, cb


    count: (criteria, cb) ->
      count User, criteria, cb  

  Post: {}