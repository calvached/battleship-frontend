namespace('Main')

# Views are like class Configuration
# They generate everything that needs to be in that one particular view
# This includes Models and Collections
# And then just send a completed view

# This view will be listening to event triggered by other views
# Conductor

class Main.View extends Backbone.View
  events:
    "click [data-id=play-button]" : 'startGame'

  render: ->
    @$el.append(new Banner.View().render())
    @$el.append("<button data-id=play-button>Play Game?</button>")

  startGame: ->
    console.log('start game!')
    @$('[data-id=play-button]').remove()
    @$el.append(new Board.View().render())

  #setListener: ->
  #  @listenTo(@view, 'blabla', @doSomething)

  #doSomething: ->
  #  console.log 'triggered'

  #triggerEvent: ->
  #  @view.trigger('blabla')


  #triggerHungry: ->
  #  @trigger('hungry')

    # news up the Board.View
    #@$('[data-id=recipes]').append(recipeView.render().el)
    # need to render the new page at this point perhaps the board view
