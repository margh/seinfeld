moment = require 'moment'
twix = require 'twix'

module.exports = class Day 
  constructor: (props) ->
    @checked = props.checked
    @moment = props.moment
    @dateString = props.dateString

  toggle: =>
    @checked = !@checked