namespace('Main')

# make sure to compile all the view ejs files in the Gruntfile
# Need to plug in Jasmine and start testing

#class Main.Test extends Backbone.Model
#  initialize: ->
#    console.log('Model seems to have been initialized...')
#
#  url: 'http://localhost:9393/hello'

class Main.View extends Backbone.View
  template: JST['app/scripts/main/view_template.ejs']

  render: ->
    @$el.html(@template())

#oneTest = new Test
#serverResponse = oneTest.fetch()
