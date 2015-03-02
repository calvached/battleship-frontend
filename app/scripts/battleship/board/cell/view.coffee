namespace('Battleship.Board.Cell')

class Battleship.Board.Cell.View extends Backbone.View
  template: JST['app/scripts/battleship/board/cell/view_template.ejs']

  tagName: 'td'

  events:
    "click .clickable" : 'updateCell'

  render: ->
    @$el.html(@template(id: @cell().id))
    @

  cell: -> @options.cell

  updateCell: ->
    @cell().fetch
      type: 'POST'
      success: @successCallback
      error: @errorCallback

  successCallback: =>
    @addStatusClass()

    if @cell().attributes.message
      FlashMessage.Handler.showErrorMessage(@cell().attributes.message)

  errorCallback: =>
    console.log 'error'

  addStatusClass: ->
    @$("[data-id=#{@cell().id}]").addClass(@cell().attributes.status)
