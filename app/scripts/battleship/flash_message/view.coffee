namespace('Battleship.FlashMessage')

class Battleship.FlashMessage.View extends Backbone.View
  template: JST['app/scripts/battleship/flash_message/view_template.ejs']

  message: -> @options.message

  styleType: -> @options.styleType

  render: ->
    @$el.html(@template
      message: @message()
      styleType: @styleType()
    )
    @
