namespace('Intro')

class Intro.View extends Backbone.View
  template: JST['app/scripts/intro/view_template.ejs']

  render: ->
    @$el.html(@template())
