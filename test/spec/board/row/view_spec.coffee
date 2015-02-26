describe 'Battleship.Board.Row.View', ->
  renderView = ->
    _v = new Battleship.Board.Row.View
      row: [
        new Battleship.Board.Cell.Model({id: 1}),
        new Battleship.Board.Cell.Model({id: 2}),
        new Battleship.Board.Cell.Model({id: 3}),
        new Battleship.Board.Cell.Model({id: 4}),
        new Battleship.Board.Cell.Model({id: 5})
      ]
    _v.render()
    _v

  it "appends cells to a row", ->
    row = renderView()

    expect(row.$el.html()).toContain(row.$('[data-id=1]').html())
    expect(row.$el.html()).toContain(row.$('[data-id=2]').html())
    expect(row.$el.html()).toContain(row.$('[data-id=3]').html())
    expect(row.$el.html()).toContain(row.$('[data-id=4]').html())
    expect(row.$el.html()).toContain(row.$('[data-id=5]').html())
