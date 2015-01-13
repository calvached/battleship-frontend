namespace('Board')

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  events:
    "click .clickable" : 'updateBoard'

  render: ->
    @appendGridCells()
    @

  gameboardElem: -> @$("[data-id=gameboard]")

  feedbackElem: -> @$("[data-id=feedback]")

  updateBoard: (event) ->
    $.ajax 'http://localhost:9393/player_move',
      type: 'POST'
      data: { move: event.target.id }
      dataType: 'json'
      error: => @errorCallback()
      success: (response, _) =>
        $('[data-id=flash-error]').fadeOut()
        @successCallback(response, event.target)

  appendGridCells: ->
    # options is not showing up
    console.log @options
    boardDimension = Math.sqrt(_.keys(@options.gameboard).length)

    _(boardDimension).times (rowIndex) =>
      @gameboardElem().append("<tr data-id=row#{rowIndex + 1}></tr>")
      @appendDataColumn(rowIndex + 1, boardDimension)

  appendDataColumn: (rowIndex, boardDimension) ->
    _(boardDimension).times (columnIndex) =>

      columnNumber = ((rowIndex - 1) * boardDimension) + columnIndex

      @$("[data-id=row#{rowIndex}]").append("<td data-id=col#{columnNumber + 1} class='cell clickable'></td>")

  errorCallback: ->
    $('[data-id=flash-error]').fadeIn()

  successCallback: (response, gridCell) ->
    @removeClickableClass(gridCell)
    @updateCellColor(gridCell, response.hitOrMiss)

    if response.shipName
      @renderShipName(response.shipName)
    else
      @renderHint(response.hint)

  removeClickableClass: (gridCell) ->
    $(gridCell).removeClass("clickable")

  updateCellColor: (gridCell, moveStatus) ->
    $(gridCell).addClass("#{moveStatus}")

  renderHint: (hint) ->
    @feedbackElem().html("#{hint}")

  renderShipName: (name) ->
    @feedbackElem().html("You have hit my #{name}!")
