namespace('Board')

# This view news up the Board model so that it can get a board and generate the HTML to display it.

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  events:
    "click .clickable" : 'updateBoard'

  render: ->
    @appendGridCells()
    @$el.html(@template())
    @

  appendGridCells: ->
    board = new Board.Gameboard

    board.fetch
      success: (model, gameboard) =>
        _.each gameboard, (cell, key) =>
          @$('[data-id=gameboard]').append("<div id=#{key} class='cell clickable' ></div>")

  updateBoard: (event) ->
    $.ajax 'http://localhost:9393/player_move',
      type: 'POST'
      data: { player_move: event.target.id }
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "AJAX STATUS: #{textStatus}"
      success: (serverResponse, textStatus, jqXHR) ->
        console.log "AJAX STATUS: #{textStatus}"
        $(event.target).removeClass( "clickable" ).addClass("#{serverResponse.status}")
