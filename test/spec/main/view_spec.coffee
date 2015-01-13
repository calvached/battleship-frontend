describe 'Main.View', ->
  renderMain = ->
    _v = new Main.View
    _v.render()
    _v

  it 'renders a Setup view', ->
    setupSpy = spyOn(Setup, "View").andReturn(new Backbone.View())

    view = renderMain()

    expect(setupSpy).toHaveBeenCalled()

  it 'appends the Setup view to the container', ->
    setupSpy = spyOn(Setup, "View").andReturn(new Backbone.View({el: '<div>Test El</div>'}))

    view = renderMain()

    expect(view.$el.html()).toContain('Test El')

  xit 'displays error message when invalid input', ->

  xit 'appends a gameboard', ->

  #xit 'updates the board', ->
#  server = sinon.fakeServer.create()
  #  server.respondWith('GET', 'http://localhost:9393/current_board', [200, { "Content-Type": "application/json" }, JSON.stringify(fakeResponse)])

  #  board = new Board.View
  #  board.render()
  #  console.log server

  #  server.respond()
  #  console.log server

# ########################## READ THIS #############################
# Main view will new up the Board model and pass in the board instance to any
# other views that need it.
# This eliminates the need to do a fetch in the Board.View
# Also need to update the board instance as click events happen
