namespace('Battleship.Game')

class Battleship.Game.View extends Backbone.View
  template: JST['app/scripts/battleship/game/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  errorElem: -> @$('[data-id=error-message]')

  render: ->
    @$el.html(@template)
    @board = new Battleship.Board.Collection
    @board.bind('change', @getGameOutcome)
    @renderSetup()
    @

  renderSetup: ->
    setup = new Battleship.Setup.View
      errorElem: @errorElem()
      board: @board

    @contentElem().html(setup.render().$el)
    @listenTo(setup, 'setupComplete', @renderBoard)

  renderBoard: ->
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

  errorCallback: =>
    console.log 'ERROR'

  renderOutcome: (response) ->
    outcome = new Battleship.Outcome.View(response)
    @contentElem().html(outcome.render().$el)
