describe 'Setup.View', ->
  renderSetup = ->
    _v = new Setup.View
      errorElem: $('<div data-id=error-message></div>')
    _v.render()
    _v

  it 'throws an error message when board size is less than 4', ->
    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()

    expect(view.options.errorElem.html()).toContain(view.invalidInputText)

  it 'throws an error message when board size is greater than 10', ->
    view = renderSetup()

    view.$('[data-id=board-size]').val('11')
    view.$('[data-id=play-button]').click()

    expect(view.options.errorElem.html()).toContain(view.invalidInputText)

  it 'does not throw an error when board size is 4', ->
    view = renderSetup()

    view.$('[data-id=board-size]').val('4')
    view.$('[data-id=play-button]').click()

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  it 'does not throw an error when board size is between 4 and 10', ->
    view = renderSetup()

    view.$('[data-id=board-size]').val('6')
    view.$('[data-id=play-button]').click()

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  it 'does not throw an error when board size is 10', ->
    view = renderSetup()

    view.$('[data-id=board-size]').val('10')
    view.$('[data-id=play-button]').click()

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  it 'clears the error message after 3 seconds', ->
    jasmine.Clock.useMock()
    view = renderSetup()

    view.$('[data-id=board-size]').val('3')
    view.$('[data-id=play-button]').click()

    expect(view.options.errorElem.html()).toContain(view.invalidInputText)

    jasmine.Clock.tick(3000)

    expect(view.options.errorElem.is(':empty')).toBeTruthy()

  xit 'posts the gameboard size', ->
    view = renderSetup()

    view.$('[data-id=board-size]').val('4')
    view.$('[data-id=play-button]').click()

    server = sinon.fakeServer.create()
    server.respondWith('GET', 'http://localhost:9393/board_size', [200, { "Content-Type": "application/json" }, JSON.stringify({})])
  #  expect successfullCallback to have been called
  #
  submitBoardSize: (boardSize) ->
    $.ajax 'http://localhost:9393/board_size',
      type: 'POST'
      xhrFields: {
        withCredentials: true
      }
      data: { board_size: boardSize }
      dataType: 'json'
      error: => @errorCallback()
      success: (response, _) =>
        @successCallback()
