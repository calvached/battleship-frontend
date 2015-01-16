namespace('Setup')

class Setup.View extends Backbone.View
  template: JST['app/scripts/setup/view_template.ejs']

  events:
    "click [data-id=play-button]" : 'submitBoardSize'

  render: ->
    @$el.html(@template())
    @

  postFailure: 'Gameboard size POST failed.'

  errorElem: -> @options.errorElem

  boardModel: -> @options.boardModel

  boardSizeData: ->
    board_size: @$('[data-id=board-size]').val()

  submitBoardSize: (boardSize) ->
    @clearElem()
    $.ajax 'http://localhost:9393/board_size',
      type: 'POST'
      xhrFields: {
        withCredentials: true
      }
      data: @boardSizeData()
      dataType: 'json'
      error: => @errorCallback()
      success: (response, _) =>
        @successCallback(response)
  # test that all data is being sent to the backend (xhrFields, data, dataType, etc)

  successCallback: (response) ->
    @resetInput()
    if response.errorMsg
      @renderErrorMsg(response.errorMsg)
    else
      @updateBoardModel(response.gameboard)
      @trigger('setupComplete')

  updateBoardModel: (freshBoard) ->
    @boardModel().set('board': freshBoard)

  renderErrorMsg: (errorMsg) ->
    @errorElem().html("<div>#{errorMsg}</div>")
    setTimeout(@clearElem, 3000)

  clearElem: =>
    @errorElem().text('')

  triggerResponseData: (response) =>
    gameboard: response.gameboard

  resetInput: ->
    @$('[data-id=board-size]').val("")

  errorCallback: ->
    @renderErrorMsg(@postFailure)
