namespace('Battleship.Board.Cell')

class Battleship.Board.Cell.View extends Backbone.View
  template: JST['app/scripts/battleship/board/cell/view_template.ejs']

  tagName: 'td'

  events:
    "click .clickable" : 'updateCell'

  render: ->
    @$el.html(@template(id: @cell().id))
    @

  errorDuration: 3000

  cell: -> @options.cell

  msgElem: -> @options.msgElem

  updateCell: ->
    @cell().fetch
      type: 'POST'
      success: @successCallback
      error: @errorCallback

  successCallback: =>
    @addStatusClass()

    if @cell().attributes.message
      @renderFlashMessage(@cell().attributes.message, 'error')

  errorCallback: =>
    console.log 'error'

  addStatusClass: ->
    @$("[data-id=#{@cell().id}]").addClass(@cell().attributes.status)

  renderFlashMessage: (message, styleType) ->
    messageView = new Battleship.FlashMessage.View
      message: message
      styleType: styleType

    @msgElem().prepend(messageView.render().$el)
    @msgElem().slideDown('slow')
    setTimeout(@hideElem, @errorDuration)

  hideElem: ->
    @msgElem().slideUp('slow', @clearElem)

  clearElem: ->
    @msgElem().html('')
