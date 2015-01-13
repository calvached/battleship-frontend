describe 'Board.View', ->
  mockGameboardModel = ->
    board = new Board.Gameboard
      gameboard: {
                   "1": '', "2": '', "3": '', "4": '',
                   "5": '', "6": '', "7": '', "8": '',
                   "9": '', "10": '', "11": '', "12": '',
                   "13": '', "14": '', "15": '', "16": '',
                 }
    board

  renderView = ->
    _v = new Board.View
      boardModel: mockGameboardModel()
    _v.render()
    _v


  xit 'renders an empty board', ->
    board = renderView()

    console.log board.$('[data-id=row1]')
    expect(board.$('[data-id=row1]')).toExist()
    expect(board.$('[data-id=col1]')).toExist()

  xit 'updates a board', ->
    #board.@$('[data-id=col1]').click()

  xit 'posts the grid cell number', ->
    # expect the successCallback to have been called


  #it 'updates the board', ->
  #  fakeResponse = {
  #        '1': "hello", 2: " ", 3: " ", 4: " ",
  #        5: " ", 6: " ", 7: " ", 8: " ",
  #        9: " ", 10: " ", 11: " ", 12: " ",
  #        13: " ", 14: " ", 15: " ", 16: " "
  #  }

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
