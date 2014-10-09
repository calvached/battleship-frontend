namespace('Banner')

class Banner.View extends Backbone.View
  template: JST['app/scripts/banner/view_template.ejs']

  render: ->
    @$el.html(@template())
