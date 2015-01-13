namespace('Setup')

class Setup.View extends Backbone.View
  template: JST['app/scripts/setup/view_template.ejs']

  events:
    "click [data-id=play-button]" : 'validateValue'

  render: ->
    @$el.html(@template())
    @

  invalidInputText: 'Invalid input. Please enter a number from 4 - 10.'

  errorElem: -> @options.errorElem

  validateValue: ->
    boardSize = @$('[data-id=board-size]').val()

    if @isValid(boardSize)
    else
      @resetInput()
      @renderErrorMsg()

  resetInput: ->
    @$('[data-id=board-size]').val("")

  renderErrorMsg: ->
    @errorElem().html("<div>#{@invalidInputText}</div>")
    setTimeout(@clearElem, 3000)

  clearElem: =>
    @errorElem().text('')

  isValid: (boardSize) ->
    boardSize < 11 && boardSize > 3 && $.isNumeric(boardSize)

