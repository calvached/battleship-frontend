namespace('Battleship.Board.Row')

class Battleship.Board.Row.View extends Backbone.View
  tagName: 'tr'

  render: ->
    @appendGridCellsToRow()
    @

  gridRow: -> @options.row

  msgElem: -> @options.msgElem

  appendGridCellsToRow: ->
    _.each @gridRow(), (cell) =>
      cellView = new Battleship.Board.Cell.View
        cell: cell
        msgElem: @msgElem()

      @$el.append(cellView.render().$el)
