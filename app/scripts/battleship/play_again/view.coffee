namespace('Battleship.PlayAgainButton')

class Battleship.PlayAgainButton.View extends Backbone.View
  template: JST['app/scripts/battleship/play_again/view_template.ejs']

  events:
    "click [data-id=play-again]" : 'replay'

  boardDimension: -> @options.boardDimension

  board: -> @options.board

  render: ->
    @$el.html(@template)
    @

  replay: ->
    @board().fetch
      data: @boardDimension()
      reset: true
      type: 'POST'
      error: @errorCallback
      success: @successCallback

  successCallback: =>
    @trigger('playAgain', @boardDimension())

  errorCallback: =>
    console.log 'error'
