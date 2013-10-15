#DB setup and any external API config

mongoose  = require 'mongoose'
_         = require 'lodash'

setup     = require './setup'
schemas    = require './schema'

dbURI     = setup.dataBaseURI
srvName   = setup.serverName
connStr   = 'mongodb://' + dbURI + '/' + srvName

# Database initialization
mongoose.connect connStr
connLength = mongoose.connections.length
console.log 'Connection #' + connLength + ' to ' + connStr

# Schema definition
appSchemas = {}
models = {}
_.forEach schemas, (v,k) ->
  appSchemas[k] = mongoose.Schema v.model
  models[k] = mongoose.model k, appSchemas[k]


module.exports = 
  db: mongoose
  schemaList: _.keys appSchemas
  models: models