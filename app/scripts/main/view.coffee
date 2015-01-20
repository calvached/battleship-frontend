namespace('Main')

class Main.View extends Backbone.View
  template: JST['app/scripts/main/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  errorElem: -> @$('[data-id=error-message]')

  render: ->
    @$el.html(@template)
    @gameboard = new Gameboard.Model
      board: {}

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
