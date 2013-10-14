(function() {
  require.config({
    paths: {
      'jquery': '/assets/components/jquery',
      'underscore': '/assets/components/lodash',
      'moment': '/assets/components/moment',
      'socket-io': '/assets/components/socket.io-client'
    },
    shim: {
      'socket-io': {
        exports: 'io'
      },
      'underscore': {
        exports: '_'
      }
    }
  });

}).call(this);
