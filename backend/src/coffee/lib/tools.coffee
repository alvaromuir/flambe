# Some utilities
moment  = require 'moment'

module.exports = 
  echo: (data) ->
    data

  shortDate: (date) ->
    moment(date).format('MM.DD.YYYY')

  fromNow: (date) ->
    moment(date).fromNow()