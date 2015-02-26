describe 'Battleship.Board.View', ->
  mockGameboard = ->
    board = new Battleship.Board.Collection(
      [
        new Battleship.Board.Cell.Model({id: 1}),
        new Battleship.Board.Cell.Model({id: 2}),
        new Battleship.Board.Cell.Model({id: 3}),
        new Battleship.Board.Cell.Model({id: 4}),
        new Battleship.Board.Cell.Model({id: 5}),
        new Battleship.Board.Cell.Model({id: 6}),
        new Battleship.Board.Cell.Model({id: 7}),
        new Battleship.Board.Cell.Model({id: 8}),
        new Battleship.Board.Cell.Model({id: 9}),
        new Battleship.Board.Cell.Model({id: 10}),
        new Battleship.Board.Cell.Model({id: 11}),
        new Battleship.Board.Cell.Model({id: 12}),
        new Battleship.Board.Cell.Model({id: 13}),
        new Battleship.Board.Cell.Model({id: 14}),
        new Battleship.Board.Cell.Model({id: 15}),
        new Battleship.Board.Cell.Model({id: 16})
    ])

    board

  renderView = ->
    _v = new Battleship.Board.View
      board: mockGameboard()
    _v.render()
    _v

  it 'renders an empty board', ->
    board = renderView()

    expect(board.$el.html()).toContain(board.$('[data-id=1]').html())
    expect(board.$el.html()).toContain(board.$('[data-id=2]').html())
    expect(board.$el.html()).toContain(board.$('[data-id=3]').html())
    expect(board.$el.html()).toContain(board.$('[data-id=4]').html())
    expect(board.$el.html()).toContain(board.$('[data-id=15]').html())
    expect(board.$el.html()).toContain(board.$('[data-id=16]').html())
