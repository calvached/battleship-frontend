namespace('Battleship.Setup')

class Battleship.Setup.View extends Backbone.View
  template: JST['app/scripts/battleship/setup/view_template.ejs']

  events:
    "click [data-id=play-button]" : 'submitBoardSize'

  render: ->
    @$el.html(@template())
    @

  errorDuration: 3000

  msgElem: -> @options.msgElem

  board: -> @options.board

  boardSizeData: ->
    board_size: @$('[data-id=board-size]').val()

  submitBoardSize: (boardSize) ->
    @clearElem()

    @board().fetch
      data: @boardSizeData()
      type: 'POST'
      success: @successCallback
      error: @errorCallback

  successCallback: =>
    @trigger('setupComplete', @boardSizeData())

  errorCallback: (_, response) =>
    @resetInput()

    if response.responseText
      @renderFlashMessage(response.responseText, 'error')
    else
      @renderFlashMessage(response.statusText, 'error')

  resetInput: ->
    @$('[data-id=board-size]').val("")

  renderFlashMessage: (message, styleType) ->
    messageView = new Battleship.FlashMessage.View
      message: message
      styleType: styleType

    @msgElem().append(messageView.render().$el)
    @msgElem().slideDown('slow')
    setTimeout(@hideElem, @errorDuration)

  hideElem: =>
    @msgElem().slideUp('slow', @clearElem)

  clearElem: =>
    @msgElem().html('')
