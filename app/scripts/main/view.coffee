namespace('Main')

class Main.View extends Backbone.View
  events:
    "click [data-id=play-button]" : 'drawBoard'

  render: ->
    @$el.append(new Banner.View().render())
    @$el.append("<button data-id=play-button>Play Game?</button>")

  drawBoard: ->
    console.log('start game!')
    @$('[data-id=play-button]').remove()
    @$el.append(new Board.View().render().$el)
