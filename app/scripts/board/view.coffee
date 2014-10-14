namespace('Board')

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  events:
    "click .clickable" : 'updateBoard'
    # test by 'clicking'

  #gameboardElem: $('[data-id=gameboard]')

  render: ->
    @$el.html(@template())
    @fetchGameboard()
    @

  updateBoard: (event) ->
    $.ajax 'http://localhost:9393/player_move',
      type: 'POST'
      data: { move: event.target.id }
      dataType: 'json'
      error: @errorCallback
      success: (response, textStatus, _) =>
        @successCallback(response, textStatus, event.target)

  fetchGameboard: ->
    board = new Board.Gameboard

    board.fetch
      success: (model, gameboard) =>
        @appendGridCells(gameboard)

  appendGridCells: (gameboard) ->
    _.each gameboard, (cell, key) =>
      $('[data-id=gameboard]').append("<div id=#{key} class='cell clickable'></div>")
      #@gameboardElem.append("<div id=#{key} class='cell clickable' ></div>")

  errorCallback: (_, textStatus) ->
    # create a div for error
    console.log "AJAX STATUS: #{textStatus}"

  successCallback: (response, textStatus, gridCell) ->
    console.log "AJAX STATUS: #{textStatus}"

    @removeClickableClass(gridCell)
    @updateCellColor(gridCell, response.moveStatus)
    @renderAnnouncement(response.announcement)

  removeClickableClass: (gridCell) ->
    $(gridCell).removeClass("clickable")

  updateCellColor: (gridCell, moveStatus) ->
    $(gridCell).addClass("#{moveStatus}")

  renderAnnouncement: (announcement) ->
    $('[data-id=announcement]').html("#{announcement}")
