describe 'Battleship.Game.View', ->
  renderGame = ->
    _v = new Battleship.Game.View
    _v.render()
    _v

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

  it 'does not render an Outcome view if a gameOutcome does not exist', ->
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    outcomeListener = spyOn(Battleship.Outcome, "View").andReturn(new Backbone.View)
    fakeServer = sinon.fakeServer.create()

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

    expect(outcomeListener).not.toHaveBeenCalled()

    fakeServer.restore()

  it 'renders an Outcome view if a gameOutcome exists', ->
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    outcomeListener = spyOn(Battleship.Outcome, "View").andReturn(new Backbone.View)
    fakeServer = sinon.fakeServer.create()

    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'You win' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(outcomeListener).toHaveBeenCalled()

    fakeServer.restore()

  it 'appends an Outcome view', ->
    fakeCollection = spyOn(Battleship.Board, "Collection").andReturn(new Backbone.Collection())
    outcomeListener = spyOn(Battleship.Outcome, "View").andReturn(new Backbone.View({el: '<div>You win</div>'}))
    fakeServer = sinon.fakeServer.create()

    fakeServer.respondWith(
      'get',
      'http://localhost:9393/game_outcome',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify({ gameOutcome: 'You win' })
      ])

    view = renderGame()

    fakeCollection().trigger('change')
    fakeServer.respond()

    expect(view.$el.html()).toContain('You win')

    fakeServer.restore()
