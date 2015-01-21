namespace('Game')

class Game.View extends Backbone.View
  template: JST['app/scripts/game/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  errorElem: -> @$('[data-id=error-message]')

  render: ->
    @$el.html(@template)
    @gameboard = new Gameboard.Model
      board: {}
      # Gameboard.Model have return {}

    @renderSetup()
    @

  renderSetup: ->
    setup = new Setup.View
      errorElem: @errorElem()
      boardModel: @gameboard

    @contentElem().html(setup.render().$el)
    @listenTo(setup, 'setupComplete', @renderGameboard)

  renderGameboard: ->
    board = new Board.View
      boardModel: @gameboard

    @contentElem().html(board.render().$el)
