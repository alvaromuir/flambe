// Generated by CoffeeScript 1.6.3
(function() {
  var appSchemas, connLength, connStr, dbURI, models, mongoose, schemas, setup, srvName, _;

  mongoose = require('mongoose');

  _ = require('lodash');

  setup = require('./setup');

  schemas = require('./schema');

  dbURI = setup.dataBaseURI;

  srvName = setup.serverName;

  connStr = 'mongodb://' + dbURI + '/' + srvName;

  mongoose.connect(connStr);

  connLength = mongoose.connections.length;

  appSchemas = {};

  models = {};

  _.forEach(schemas, function(v, k) {
    appSchemas[k] = mongoose.Schema(v.model);
    return models[k] = mongoose.model(k, appSchemas[k]);
  });

  module.exports = {
    db: mongoose,
    schemaList: _.keys(appSchemas),
    models: models
  };

}).call(this);
