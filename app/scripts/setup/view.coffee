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

  boardModel: -> @options.boardModel

  boardSizeData: ->
    board_size: @$('[data-id=board-size]').val()

  submitBoardSize: (boardSize) ->
    @clearElem()
    $.ajax 'http://localhost:9393/new_game',
    #@boardModel().fetch
      type: 'POST'
      xhrFields: {
        withCredentials: true
      }
      data: @boardSizeData()
      dataType: 'json'
      error: (response, _) => @errorCallback(response)
      success: (response, _) => @successCallback(response)

  successCallback: (response) ->
    @updateBoardModel(response.gameboard)
    @trigger('setupComplete')

  errorCallback: (response) ->
    @resetInput()

    if response.responseText
      @renderErrorMsg(response.responseText)
    else
      @renderErrorMsg(response.statusText)

  updateBoardModel: (freshBoard) ->
    @boardModel().set('board': freshBoard)

  renderErrorMsg: (errorMsg) ->
    @errorElem().html("<div>#{errorMsg}</div>")
    setTimeout(@clearElem, @errorDuration)

  clearElem: =>
    @errorElem().text('')

  triggerResponseData: (response) =>
    gameboard: response.gameboard

  resetInput: ->
    @$('[data-id=board-size]').val("")
