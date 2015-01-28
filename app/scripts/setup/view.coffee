namespace('Setup')

class Setup.View extends Backbone.View
  template: JST['app/scripts/setup/view_template.ejs']

  events:
    "click [data-id=play-button]" : 'submitBoardSize'

  render: ->
    @$el.html(@template())
    @

  errorDuration: 3000

  errorElem: -> @options.errorElem

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
    @trigger('setupComplete')

  errorCallback: (_, response) =>
    @resetInput()

    if response.responseText
      @renderErrorMsg(response.responseText)
    else
      @renderErrorMsg(response.statusText)

  renderErrorMsg: (errorMsg) ->
    @errorElem().html("<div>#{errorMsg}</div>")
    setTimeout(@clearElem, @errorDuration)

  clearElem: =>
    @errorElem().text('')

  resetInput: ->
    @$('[data-id=board-size]').val("")
