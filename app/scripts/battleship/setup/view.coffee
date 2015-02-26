namespace('Battleship.Setup')

class Battleship.Setup.View extends Backbone.View
  template: JST['app/scripts/battleship/setup/view_template.ejs']

  events:
    "click [data-id=play-button]" : 'submitBoardSize'

  render: ->
    @$el.html(@template())
    @

  board: -> @options.board

  boardSizeData: ->
    board_size: @$('[data-id=board-size]').val()

  submitBoardSize: (boardSize) ->
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
      Battleship.FlashMessage.Builder.showErrorMessage(response.responseText)
    else
      Battleship.FlashMessage.Builder.showErrorMessage(response.statusText)

  resetInput: ->
    @$('[data-id=board-size]').val("")
