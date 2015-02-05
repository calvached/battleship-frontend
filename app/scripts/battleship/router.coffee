namespace('App')
# Views can render their own views
# Main View will house all the other views
# Router can change or add views to the main view

class App.Router extends Backbone.Router
  routes:
    '': 'defaultRoute'

  container: $("[data-id=container]")

  defaultRoute: ->
    @container.html(new Battleship.Game.View().render().el)

  #makeModel: ->
  #  oneTest = new Board.Current
  #  serverResponse = oneTest.fetch()
  #  console.log(serverResponse)

# who news up the model/s? Answer: Usually the views
# need to figure out how to use the obj that fetch() returns!
