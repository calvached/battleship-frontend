namespace('Battleship.Board.Row')

class Battleship.Board.Row.View extends Backbone.View
  tagName: 'tr'

  render: ->
    @appendGridCellsToRow()
    @

  gridRow: -> @options.row

  appendGridCellsToRow: ->
    _.each @gridRow(), (cell) =>
      cellView = new Battleship.Board.Cell.View
        cell: cell

      @$el.append(cellView.render().$el)
