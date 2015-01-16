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
