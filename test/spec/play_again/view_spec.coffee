describe 'Battleship.PlayAgainButton.View', ->
  renderButton = ->
    _v = new Battleship.PlayAgainButton.View
      boardDimension: { board_size: '5' }
      board: new Battleship.Board.Collection({ fakeModel: 'model' })
    _v.render()
    _v

  it 'renders a PlayAgainButton view', ->
    view = renderButton()

    expect(view.$el.html()).toContain('Play Again?')

  it 'posts the board dimension on click', ->
    fakeServer = sinon.fakeServer.create()
    fakeServer.respondWith(
      'post',
      'http://localhost:9393/new',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify([])
      ])

    view = renderButton()

    view.$('[data-id=play-again]').click()
    fakeServer.respond()

    postedData = fakeServer.requests[0].requestBody
    expect(postedData).toEqual('board_size=5')

  it 'executes a trigger', ->
    fakeListener = spyOn(Backbone, "View")
    fakeServer = sinon.fakeServer.create()
    fakeServer.respondWith(
      'post',
      'http://localhost:9393/new',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify([])
      ])

    view = renderButton()
    view.listenTo(view, 'playAgain', fakeListener)

    view.$('[data-id=play-again]').click()
    fakeServer.respond()

    expect(fakeListener).toHaveBeenCalled()


  it 'resets the gameboard', ->
    fakeServer = sinon.fakeServer.create()
    fakeServer.respondWith(
      'post',
      'http://localhost:9393/new',
      [
        200,
        { "content-type": "application/json" },
        JSON.stringify([])
      ])

    view = renderButton()

    expect(view.board().length).not.toEqual(0)

    view.$('[data-id=play-again]').click()
    fakeServer.respond()

    expect(view.board().length).not.toEqual(1)
