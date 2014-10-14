namespace('Board')

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  events:
    "click .clickable" : 'updateBoard'
    # test by 'clicking'

  render: ->
    @$el.html(@template())
    @fetchGameboard()
    @

  #gameboardElem: $('[data-id=gameboard]')

  updateBoard: (event) ->
    $.ajax 'http://localhost:9393/player_move',
      type: 'POST'
      data: { move: event.target.id }
      dataType: 'json'
      error: => @errorCallback()
      success: (response, _) =>
        $('[data-id=flash-error]').fadeOut()
        @successCallback(response, event.target)

  fetchGameboard: ->
    board = new Board.Gameboard

    board.fetch
      success: (model, gameboard) =>
        @appendGridCells(gameboard)

  appendGridCells: (gameboard) ->
    _.each gameboard, (cell, key) =>
      $('[data-id=gameboard]').append("<div id=#{key} class='cell clickable'></div>")
      #@gameboardElem.append("<div id=#{key} class='cell clickable'></div>")

  errorCallback: ->
    $('[data-id=flash-error]').fadeIn()

  successCallback: (response, gridCell) ->
    @removeClickableClass(gridCell)
    @updateCellColor(gridCell, response.moveStatus)
    @renderAnnouncement(response.announcement)

  removeClickableClass: (gridCell) ->
    $(gridCell).removeClass("clickable")

  updateCellColor: (gridCell, moveStatus) ->
    $(gridCell).addClass("#{moveStatus}")

  renderAnnouncement: (announcement) ->
    $('[data-id=announcement]').html("#{announcement}")
