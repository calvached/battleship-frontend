namespace('Board')

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  render: ->
    @$el.html(@template)
    @appendGridCells()
    @

  board: -> @options.board

  gameboardElem: -> @$("[data-id=gameboard]")

  feedbackElem: -> @$("[data-id=feedback]")

  appendGridCells: ->
    boardDimension = Math.sqrt(@board().length)

    _(boardDimension).times (rowIndex) =>
      @gameboardElem().append("<tr data-id=row#{rowIndex + 1}></tr>")
      @appendDataColumn(rowIndex + 1, boardDimension)

  appendDataColumn: (rowIndex, boardDimension) ->
    _(boardDimension).times (columnIndex) =>

      columnNumber = ((rowIndex - 1) * boardDimension) + columnIndex

      @$("[data-id=row#{rowIndex}]").append("<td data-id=col#{columnNumber + 1} class='cell clickable'></td>")
