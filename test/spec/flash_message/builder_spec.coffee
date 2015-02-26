describe 'Battleship.FlashMessage.Builder', ->
  it 'it shows a win message', ->
    setFixtures("<div data-id='message-content'></div>")
    messageSpy = spyOn(Battleship.FlashMessage, 'View').andReturn(new Backbone.View())

    Battleship.FlashMessage.Builder.showWinMessage()

    expect(messageSpy).toHaveBeenCalled()

  it 'it shows a lose message', ->
    setFixtures("<div data-id='message-content'></div>")
    messageSpy = spyOn(Battleship.FlashMessage, 'View').andReturn(new Backbone.View())

    Battleship.FlashMessage.Builder.showLoseMessage()
    expect(messageSpy).toHaveBeenCalled()

  it 'it shows an error message', ->
    setFixtures("<div data-id='message-content'></div>")

    messageSpy = spyOn(Battleship.FlashMessage, 'View').andReturn(new Backbone.View())

    Battleship.FlashMessage.Builder.showErrorMessage()
    expect(messageSpy).toHaveBeenCalled()

  it 'displays a message for 3 seconds', ->
    jasmine.Clock.useMock()
    slideDownSpy = spyOn($.fn, 'slideDown')
    slideUpSpy = spyOn($.fn, 'slideUp')

    Battleship.FlashMessage.Builder.showWinMessage()

    expect(slideDownSpy).toHaveBeenCalled()

    jasmine.Clock.tick(3000)

    expect(slideUpSpy).toHaveBeenCalled()
