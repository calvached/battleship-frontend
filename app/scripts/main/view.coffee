namespace('Main')

class Main.View extends Backbone.View
  events:
    "click [data-id=play-button]" : 'validateValue'

  render: ->
    # need to figure out how to have el attach to an element already in existence instead of creating a new div each time.
    introView = new Intro.View().render()
    @$el.append(introView)
    # @

  invalidMsgElem: $('[data-id=invalid-message]')

  errorMsgElem: $('[data-id=flash-error]')

  validateValue: ->
    boardSize = @$('[name=board-size]').val()

    if @isValid(boardSize)
      @submitBoardSize(boardSize)
      @invalidMsgElem.fadeOut(100)
    else
      @resetInput()
      @invalidMsgElem.fadeIn(200)

  isValid: (boardSize) ->
    boardSize < 11 && boardSize > 3 && $.isNumeric(boardSize)

  resetInput: ->
    @$('[name=board-size]').val("")

  submitBoardSize: (boardSize) ->
    $.ajax 'http://localhost:9393/board_size',
      type: 'POST'
      data: { board_size: boardSize }
      dataType: 'json'
      error: => @errorCallback()
      success: (response, _) =>
        @successCallback()
        console.log response

  errorCallback: ->
    @errorMsgElem.fadeIn(200)

  successCallback: ->
    @errorMsgElem.hide()
    @renderGameboard()

  renderGameboard: ->
    @removeForm()
    @drawBoard()

  removeForm: ->
    $('[data-id=board-size-form]').remove()

  drawBoard: ->
    console.log('start game!')
    @$el.append(new Board.View().render().$el)
    #@$el.append(new Feedback.View().render().$el)
    #@$el.append(new StatSummary.View().render().$el)


    #You won in 4 moves
    #You won in 25 moves
