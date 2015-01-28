describe 'Setup.View', ->
  fakeServer = null

  renderSetup = ->
    _v = new Setup.View
      errorElem: $('<div data-id=error-message></div>')
      board: new Game.BoardCollection
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
    view = renderSetup()

    view.$('[data-id=board-size]').val('6')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.html()).toContain('Not Found')

  it 'throws an error message on an invalid post', ->
    fakeServer.respondWith('POST', 'http://localhost:9393/new', [400, { "Content-Type": "application/json" }, JSON.stringify(errorPostData())])
    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.html()).toContain(errorPostData())

  it 'clears the error message after 3 seconds', ->
    jasmine.Clock.useMock()
    fakeServer.respondWith('POST', 'http://localhost:9393/new', [400, { "Content-Type": "application/json" }, JSON.stringify(errorPostData())])

    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.html()).toContain(errorPostData())

    jasmine.Clock.tick(3000)

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  it 'does not throw an error message if it does not exist', ->
    fakeServer.respondWith('POST', 'http://localhost:9393/new', [200, { "Content-Type": "application/json" }, JSON.stringify([])])

    view = renderSetup()

    view.$('[data-id=board-size]').val('4')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

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
