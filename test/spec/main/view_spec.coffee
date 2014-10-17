describe 'Main.View', ->
  it 'passes a test!', ->
    x = 1 + 1
    expect(x).toEqual(2)

  it 'renders a template', ->
    view = new Main.View
    view.render()

    expect(view.el.innerHTML).toContain('Battleship')

  xit '', ->
  xit '', ->


# BoardView
# import using Bower
#
# server = sinon.fakeServer.create();
# server.respondWith("GET", "http://localhost:9393/current_board", [200, {1: '', 2: '', ...}, "OK"]);
# assert that data-ids exist
#
# Create div for error message
# Assert against div
#
# Test when click on another cell the div is emptied
