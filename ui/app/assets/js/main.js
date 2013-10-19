(function() {
  require(['config'], function(config) {
    requirejs.config(config);
    return require(["app", "jquery", "utils", "moment", "socket-io"], function(app, $, utils) {
      return "use strict";
    });
  });

}).call(this);
