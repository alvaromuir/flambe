require ['config'], (config) ->
  requirejs.config(config)

  require ["app", "jquery", "utils", "moment", "socket-io" ], (app, $, utils) ->
    "use strict"