moment = require 'moment'
twix = require 'twix'

module.exports = class Day 
  constructor: (props) ->
    @checked = props.checked
    @dateString = props.dateString
    @moment = moment(@dateString, 'DD-MM-YYYY')

  toggle: =>
    @checked = !@checked