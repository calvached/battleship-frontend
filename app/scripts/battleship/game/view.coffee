namespace('Battleship.Game')

class Battleship.Game.View extends Backbone.View
  template: JST['app/scripts/battleship/game/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  render: ->
    @$el.html(@template)
    @board = new Battleship.Board.Collection
    @board.bind('change', @getGameOutcome)
    @renderSetup()
    @

  renderSetup: ->
    setup = new Battleship.Setup.View
      board: @board

    @contentElem().html(setup.render().$el)
    @listenTo(setup, 'setupComplete', @renderBoard)

  renderBoard: (@boardDimension) =>
    gameboard = new Battleship.Board.View
      board: @board

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
      @renderPlayAgainButton()

  errorCallback: =>
    console.log 'ERROR'

  renderPlayAgainButton: =>
    @board = new Battleship.Board.Collection
    @board.bind('change', @getGameOutcome)

    playButton = new Battleship.PlayAgainButton.View
      boardDimension: @boardDimension
      board: @board

    @contentElem().append(playButton.render().$el)
    @listenTo(playButton, 'playAgain', @renderBoard)

  renderOutcome: (response) ->
    if @isWin(response)
      FlashMessage.Handler.showWinMessage()
    else
      FlashMessage.Handler.showLoseMessage()

  disableGameboard: ->
    @$('table td').off()

  isWin: (response) =>
    response.gameOutcome == 'win'
