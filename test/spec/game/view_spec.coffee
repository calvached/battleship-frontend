describe 'Game.View', ->
  renderGame = ->
    _v = new Game.View
    _v.render()
    _v

  it 'renders a Setup view', ->
    setupSpy = spyOn(Setup, "View").andReturn(new Backbone.View())

    view = renderGame()

    expect(setupSpy).toHaveBeenCalled()

  it 'appends the setup options', ->
    setupSpy = spyOn(Setup, "View").andReturn(new Backbone.View({el: '<div>Test El</div>'}))

    view = renderGame()

    expect(view.$el.html()).toContain('Test El')

  xit 'appends a new gameboard', ->
