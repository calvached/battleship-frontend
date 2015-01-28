describe 'Board.View', ->
  mockGameboard = ->
    board = new Game.BoardCollection([
      new Game.CellModel, new Game.CellModel, new Game.CellModel,new Game.CellModel,
      new Game.CellModel, new Game.CellModel, new Game.CellModel, new Game.CellModel,
      new Game.CellModel, new Game.CellModel, new Game.CellModel, new Game.CellModel,
      new Game.CellModel, new Game.CellModel, new Game.CellModel, new Game.CellModel
    ])

    board

  renderView = ->
    _v = new Board.View
      board: mockGameboard()
    _v.render()
    _v

  it 'renders an empty board', ->
    board = renderView()

    expect(board.$el.html()).toContain(board.$('[data-id=row1]').html())
    expect(board.$el.html()).toContain(board.$('[data-id=col1]').html())
