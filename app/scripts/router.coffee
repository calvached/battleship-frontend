namespace('App')
# Views can render their own views
# Main View will house all the other views
# Router can change or add views to the main view

class App.Router extends Backbone.Router
  routes:
    '': 'defaultRoute'

  container: $("[data-id='container']")

  defaultRoute: ->
    @container.html(new Main.View().render())
