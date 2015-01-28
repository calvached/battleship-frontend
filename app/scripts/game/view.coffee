namespace('Game')

class Game.View extends Backbone.View
  template: JST['app/scripts/game/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  errorElem: -> @$('[data-id=error-message]')

  render: ->
    @$el.html(@template)
    @board = new Game.BoardCollection
    @renderSetup()
    @

  renderSetup: ->
    setup = new Setup.View
      errorElem: @errorElem()
      board: @board

    @contentElem().html(setup.render().$el)
    @listenTo(setup, 'setupComplete', @renderGameboard)

  renderGameboard: ->
    gameboard = new Board.View
      board: @board

    @contentElem().html(gameboard.render().$el)
