namespace('Battleship.FlashMessage')

class Battleship.FlashMessage.Builder
  @duration: 3000

  @winMessage: "You have won!"

  @loseMessage: "You have lost!"

  @winStyleType: 'win'

  @loseStyleType: 'lose'

  @errorStyleType: 'error'

  @msgElem: -> $('[data-id=message-content]')

  @renderFlashMessage: (message, styleType) ->
    messageView = new Battleship.FlashMessage.View
      message: message
      styleType: styleType

    @msgElem().prepend(messageView.render().$el)
    @msgElem().slideDown('slow')
    setTimeout(@hideElem, @duration)

  @hideElem: =>
    @msgElem().slideUp('slow', @clearElem)

  @clearElem: =>
    @msgElem().html('')

  @showWinMessage: ->
    @renderFlashMessage(@winMessage, @winStyleType)

  @showLoseMessage: ->
    @renderFlashMessage(@loseMessage, @loseStyleType)

  @showErrorMessage: (message) ->
    @renderFlashMessage(message, @errorStyleType)
