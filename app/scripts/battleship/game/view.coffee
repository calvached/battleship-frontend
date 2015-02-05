namespace('Battleship.Game')

class Battleship.Game.View extends Backbone.View
  template: JST['app/scripts/battleship/game/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  errorElem: -> @$('[data-id=error-message]')

  render: ->
    @$el.html(@template)
    @board = new Battleship.Board.Collection
    @renderSetup()
    @

  renderSetup: ->
    setup = new Battleship.Setup.View
      errorElem: @errorElem()
      board: @board

    @contentElem().html(setup.render().$el)
    @listenTo(setup, 'setupComplete', @renderGameboard)

  renderGameboard: ->
    gameboard = new Battleship.Board.View
      board: @board

    @contentElem().html(gameboard.render().$el)
