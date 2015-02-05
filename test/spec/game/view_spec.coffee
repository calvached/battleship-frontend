describe 'Battleship.Game.View', ->
  renderGame = ->
    _v = new Battleship.Game.View
    _v.render()
    _v

  it 'renders a Setup view', ->
    setupSpy = spyOn(Battleship.Setup, "View").andReturn(new Backbone.View())

    view = renderGame()

    expect(setupSpy).toHaveBeenCalled()

  it 'appends the setup options', ->
    setupSpy = spyOn(Battleship.Setup, "View").andReturn(new Backbone.View({el: '<div>Test El</div>'}))

    view = renderGame()

    expect(view.$el.html()).toContain('Test El')
