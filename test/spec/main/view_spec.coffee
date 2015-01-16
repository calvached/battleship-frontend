describe 'Main.View', ->
  renderMain = ->
    _v = new Main.View
    _v.render()
    _v

  it 'renders a Setup view', ->
    setupSpy = spyOn(Setup, "View").andReturn(new Backbone.View())

    view = renderMain()

    expect(setupSpy).toHaveBeenCalled()

  it 'appends the setup options', ->
    setupSpy = spyOn(Setup, "View").andReturn(new Backbone.View({el: '<div>Test El</div>'}))

    view = renderMain()

    expect(view.$el.html()).toContain('Test El')

  xit 'appends a new gameboard', ->
