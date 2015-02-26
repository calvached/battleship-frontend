describe 'Battleship.Game.View', ->
  fakeServer = null

  renderGame = ->
    _v = new Battleship.Game.View
    _v.render()
    _v

  beforeEach ->
    fakeServer = sinon.fakeServer.create()

  afterEach ->
    fakeServer.restore()

  it 'renders a Setup view', ->
    setupSpy = spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())

    view = renderGame()

    expect(setupSpy).toHaveBeenCalled()

  it 'appends the Setup options', ->
    setupSpy = spyOn(Battleship.Setup, "View").andReturn(new Backbone.View({el: '<div>Test El</div>'}))

    view = renderGame()

    expect(view.$el.html()).toContain('Test El')

  it 'renders a Board view', ->
    setupSpy = spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())
    boardSpy = spyOn(Battleship.Board, "View").andReturn(new Backbone.View())

    view = renderGame()

    setupSpy().trigger('setupComplete')

    expect(boardSpy).toHaveBeenCalled()

  it 'does not render a win or lose message if a gameOutcome does not exist', ->
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    winListener = spyOn(Battleship.FlashMessage.Builder, "showWinMessage")
    loseListener = spyOn(Battleship.FlashMessage.Builder, "showLoseMessage")
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({})
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(winListener).not.toHaveBeenCalled()
    expect(loseListener).not.toHaveBeenCalled()

  it 'renders a win Message view if a win gameOutcome exists', ->
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    winListener = spyOn(Battleship.FlashMessage.Builder, "showWinMessage")
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'win' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(winListener).toHaveBeenCalled()

  it 'renders a lose Message view if a lose gameOutcome exists', ->
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    loseListener = spyOn(Battleship.FlashMessage.Builder, "showLoseMessage")
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'lose' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(loseListener).toHaveBeenCalled()

  it 'disables the gameboard after the game ends', ->
    disableSpy = spyOn($.fn, 'off')
    setupSpy = spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())
    spyOn(Battleship.Board, "View").andReturn(new Backbone.View({el: '<table><tr><td>Cell 1</td></tr></table>'}))
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'win' })
      ])

    view = renderGame()

    setupSpy().trigger('setupComplete')

    expect(disableSpy).not.toHaveBeenCalled()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(disableSpy).toHaveBeenCalled()

  it "renders a 'Play Again' button when the game has ended", ->
    spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    playListener = spyOn(Battleship.PlayAgainButton, "View").andReturn(new Backbone.View({el: '<div>Play Again?</div>'}))
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'win' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(playListener).toHaveBeenCalled()

  it "appends a 'Play Again' button when the game has ended", ->
    spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    spyOn(Battleship.PlayAgainButton, "View").andReturn(new Backbone.View({el: '<div>Play Again?</div>'}))
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'win' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(view.$el.html()).toContain('Play Again?')

  it "re-renders a board on a successful trigger", ->
    spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())
    boardSpy = spyOn(Battleship.Board, "View").andReturn(new Backbone.View())
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    playListener = spyOn(Battleship.PlayAgainButton, "View").andReturn(new Backbone.View())
    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'win' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    playListener().trigger('playAgain')

    expect(boardSpy).toHaveBeenCalled()
