module.exports = class Day
  constructor: (props) ->
    @checked = props.checked
    @moment = props.moment
    @dateString = props.dateString
    @notes = props.notes

  toggle: =>
    @checked = !@checked