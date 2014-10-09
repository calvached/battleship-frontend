namespace('Main')

# Views are like class Configuration
# They generate everything that needs to be in that one particular view
# This includes Models and Collections
# And then just send a completed view

# This view will be listening to event triggered by other views
# Conductor

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

  #setListener: ->
  #  @listenTo(@view, 'blabla', @doSomething)

  #doSomething: ->
  #  console.log 'triggered'

  #triggerEvent: ->
  #  @view.trigger('blabla')


  #triggerHungry: ->
  #  @trigger('hungry')

# Need an event listener on each div that's part of the board
# Perhaps a clickable class?
# Then get the data-id number to distinguish from other divs

