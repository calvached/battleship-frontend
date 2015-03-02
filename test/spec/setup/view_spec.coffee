describe 'Battleship.Setup.View', ->
  fakeServer = null

  renderSetup = ->
    _v = new Battleship.Setup.View
      board: new Battleship.Board.Collection
    _v.render()
    _v

  errorPostData = -> "Invalid input."

  beforeEach ->
    fakeServer = sinon.fakeServer.create()

  afterEach ->
    fakeServer.restore()

  it 'posts the gameboard size', ->
    fakeServer.respondWith('POST', 'http://localhost:9393/new', [200, { "Content-Type": "application/json" }, JSON.stringify([])])

    view = renderSetup()

    view.$('[data-id=board-size]').val('6')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    postedData = fakeServer.requests[0].requestBody

    expect(postedData).toEqual('board_size=6')

  it 'throws an error on an unsuccessful post', ->
    messageSpy = spyOn(FlashMessage.Handler, 'showErrorMessage')
    view = renderSetup()

    view.$('[data-id=board-size]').val('6')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(messageSpy).toHaveBeenCalled()

  it 'throws an error message on an invalid post', ->
    messageSpy = spyOn(FlashMessage.Handler, 'showErrorMessage')
    fakeServer.respondWith('POST', 'http://localhost:9393/new', [400, { "Content-Type": "application/json" }, JSON.stringify(errorPostData())])
    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(messageSpy).toHaveBeenCalled()

  it 'does not throw an error message if it does not exist', ->
    messageSpy = spyOn(FlashMessage.Handler, 'showErrorMessage')
    fakeServer.respondWith('POST', 'http://localhost:9393/new', [200, { "Content-Type": "application/json" }, JSON.stringify([])])

    view = renderSetup()

    view.$('[data-id=board-size]').val('6')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(messageSpy).not.toHaveBeenCalled()

  it 'executes a trigger', ->
    fakeListener = spyOn(Backbone, "View")
    fakeServer.respondWith(
      'POST'
      'http://localhost:9393/new'
      [200, {}, JSON.stringify([])]
    )

    view = renderSetup()
    view.listenTo(view, 'setupComplete', fakeListener)

    view.$('[data-id=board-size]').val('6')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(fakeListener).toHaveBeenCalled()
