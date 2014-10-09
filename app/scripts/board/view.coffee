namespace('Board')

# This view news up the Board model so that it can get a board and generate the HTML to display it.

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  events:
    "click .clickable" : 'updateBoard'

  render: ->
    @appendGridCells()
    @$el.html(@template())

  appendGridCells: ->
    board = new Board.Gameboard

    board.fetch
      success: (model, serverResponse) =>
        _.each serverResponse, (cell, key) =>
          @$('[data-id=gameboard]').append("<div id=#{key} class='cell clickable' ></div>")

  updateBoard: (event) ->
    console.log event.target.id
    console.log 'cell clicked!'

    # need to end the target id over to the backend to check whether hit/miss
