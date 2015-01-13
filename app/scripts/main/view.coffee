namespace('Main')

class Main.View extends Backbone.View
  template: JST['app/scripts/main/view_template.ejs']

  contentElem: -> @$('[data-id=content]')

  errorElem: -> @$('[data-id=error-message]')

  render: ->
    @$el.html(@template)
    @renderSetup()
    @

  renderSetup: ->
    setup = new Setup.View(errorElem: @errorElem()).render().$el
    @contentElem().html(setup)
