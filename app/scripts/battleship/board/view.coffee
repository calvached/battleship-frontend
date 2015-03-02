namespace('Battleship.Board')

class Battleship.Board.View extends Backbone.View
  template: JST['app/scripts/battleship/board/view_template.ejs']

  render: ->
    @$el.html(@template)
    @appendRows()
    @

  board: -> @options.board

  gameboardElem: -> @$("[data-id=gameboard]")

  appendRows: ->
    boardDimension = Math.sqrt(@board().length)
    rows =  @sliceIntoRows(boardDimension, @board().models)

    _.each rows, (row) =>
      @gameboardElem().append(@createRow(row).render().$el)

  createRow: (row) ->
    new Battleship.Board.Row.View
      row: row

  sliceIntoRows: (size, boardCells) ->
    row = []
    i = 0

    while i < boardCells.length
      row.push(boardCells.slice(i, i + size))
      i += size

    row
