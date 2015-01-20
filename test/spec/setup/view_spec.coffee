describe 'Setup.View', ->
  fakeServer = null

  renderSetup = ->
    _v = new Setup.View
      errorElem: $('<div data-id=error-message></div>')
      boardModel: new Gameboard.Model(board: {})
    _v.render()
    _v

  errorPostData = -> { errorMsg: "Invalid input. Please enter a number from 4 - 10." }

  successPostData = -> {
                         gameboard: {
                            '1': '', '2': '', '3': '', '4': '',
                            '5': '', '6': '', '7': '', '8': '',
                            '9': '', '10': '', '11': '', '12': '',
                            '13': '', '14': '', '15': '', '16': ''
                          }
                       }

  beforeEach ->
    fakeServer = sinon.fakeServer.create()

  afterEach ->
    fakeServer.restore()

  it 'posts the gameboard size', ->
    fakeServer.respondWith('POST', 'http://localhost:9393/board_size', [200, { "Content-Type": "application/json" }, JSON.stringify({})])

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

    expect(view.options.errorElem.html()).toContain(view.postFailure)

  it 'throws an error message if one exists after a post', ->
    fakeServer.respondWith('POST', 'http://localhost:9393/board_size', [200, { "Content-Type": "application/json" }, JSON.stringify(errorPostData())])

    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.html()).toContain(errorPostData().errorMsg)

  it 'clears the error message after 3 seconds', ->
    jasmine.Clock.useMock()
    fakeServer.respondWith('POST', 'http://localhost:9393/board_size', [200, { "Content-Type": "application/json" }, JSON.stringify(errorPostData())])

    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.html()).toContain(errorPostData().errorMsg)

    jasmine.Clock.tick(3000)

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  it 'does not throw an error message if it does not exist', ->
    fakeServer.respondWith('POST', 'http://localhost:9393/board_size', [200, { "Content-Type": "application/json" }, JSON.stringify({})])

    view = renderSetup()

    view.$('[data-id=board-size]').val('4')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  it 'executes a trigger', ->
    fakeListener = spyOn(Backbone, 'View')
    testModel = spyOn(Backbone, 'Model')
    fakeServer.respondWith('POST', 'http://localhost:9393/board_size', [200, { "Content-Type": "application/json" }, JSON.stringify(successPostData())])

    view = renderSetup()
    view.listenTo(view, 'setupComplete', fakeListener)

    view.$('[data-id=board-size]').val('4')
    view.$('[data-id=play-button]').click()
    fakeServer.respond()

    expect(fakeListener).toHaveBeenCalled()
