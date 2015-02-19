namespace('Battleship.Game')

class Battleship.Game.View extends Backbone.View
  template: JST['app/scripts/battleship/game/view_template.ejs']

  winMessage: 'You win!'

  loseMessage: 'You lose!'

  errorDuration: 3000

  contentElem: -> @$('[data-id=content]')

  msgElem: -> @$('[data-id=message-content]')

  render: ->
    @$el.html(@template)
    @board = new Battleship.Board.Collection
    @board.bind('change', @getGameOutcome)
    @renderSetup()
    @

  renderSetup: ->
    setup = new Battleship.Setup.View
      msgElem: @msgElem()
      board: @board

    @contentElem().html(setup.render().$el)
    @listenTo(setup, 'setupComplete', @renderBoard)

  renderBoard: ->
    gameboard = new Battleship.Board.View
      board: @board
      msgElem: @msgElem()

    @contentElem().html(gameboard.render().$el)

  getGameOutcome: =>
    $.ajax 'http://localhost:9393/game_outcome',
      type: 'GET'
      dataType: 'json'
      error: @errorCallback
      success: @successCallback

  successCallback: (response) =>
    if response.gameOutcome
      @renderOutcome(response)
      @disableGameboard()

  errorCallback: =>
    console.log 'ERROR'

  renderOutcome: (response) ->
    if @isWin(response)
      @renderFlashMessage(@winMessage, response.gameOutcome)
    else
      @renderFlashMessage(@loseMessage, response.gameOutcome)

  disableGameboard: ->
    @$('table td').off()

  isWin: (response) =>
    response.gameOutcome == 'win'

  renderFlashMessage: (message, styleType) ->
    messageView = new Battleship.FlashMessage.View
      message: message
      styleType: styleType

    @msgElem().prepend(messageView.render().$el)
    @msgElem().slideDown('slow')
    setTimeout(@hideElem, @errorDuration)

  hideElem: =>
    @msgElem().slideUp('slow', @clearElem)

  clearElem: =>
    @msgElem().html('')
