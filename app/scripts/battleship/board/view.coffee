namespace('Battleship.Board')

class Battleship.Board.View extends Backbone.View
  template: JST['app/scripts/battleship/board/view_template.ejs']

  render: ->
    @$el.html(@template)
    @appendRows()
    @

  board: -> @options.board

  msgElem: -> @options.msgElem

  gameboardElem: -> @$("[data-id=gameboard]")

  appendRows: ->
    boardDimension = Math.sqrt(@board().length)
    clonedBoard = _.extend({}, @board())

    _(boardDimension).times (rowIndex) =>
      @gameboardElem().append(@createdRow(boardDimension, clonedBoard).render().$el)

  createdRow: (boardDimension, board) ->
    new Battleship.Board.Row.View
      row: @sliceIntoRowCells(boardDimension, board.models)
      msgElem: @msgElem()

  sliceIntoRowCells: (boardDimension, boardCells) =>
    row = []

    _(boardDimension).times (cellIndex) =>
      cell = boardCells.shift()
      row.push(cell)

    row
