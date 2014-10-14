namespace('Main')

class Main.View extends Backbone.View
  events:
    "click [data-id=play-button]" : 'validateValue'

  render: ->
    # need to figure out how to have el attach to an element already in existence instead of creating a new div each time.
    bannerView = new Banner.View().render()
    @$el.append(bannerView)
    @$el.append("<p>Please input your preferred board size:</p>")
    @$el.append("<input type=text name=board-size><br>")
    @$el.append("<button data-id=play-button>Play Game?</button>")

  renderGameboard: ->
    @removeButton()
    @removeInputField()
    @drawBoard()

  submitBoardSize: (boardSize) ->
    $.ajax 'http://localhost:9393/board_size',
      type: 'POST'
      data: { board_size: boardSize }
      dataType: 'json'
      error: => console.log 'Error!'
      success: (response, textStatus, _) =>
        console.log response

  validateValue: ->
    boardSize = @$('[name=board-size]').val()

    if @isValid(boardSize)
      @submitBoardSize(boardSize)
      @renderGameboard()
    else
      @$('[name=board-size]').val("")

  isValid: (boardSize) ->
    boardSize < 10 && boardSize > 4 && $.isNumeric(boardSize)

  removeInputField: ->
    @$('p').remove()
    @$('[name=board-size]').remove()

  removeButton: ->
    @$('[data-id=play-button]').remove()

  drawBoard: ->
    console.log('start game!')
    @$el.append(new Board.View().render().$el)
    #@$el.append(new Feedback.View().render().$el)
    #@$el.append(new StatSummary.View().render().$el)
    #
    #
    #You won in 4 moves
    #You won in 25 moves
