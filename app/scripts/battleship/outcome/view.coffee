namespace('Battleship.Outcome')

class Battleship.Outcome.View extends Backbone.View
  template: JST['app/scripts/battleship/outcome/view_template.ejs']

  outcome: -> @options.gameOutcome

  render: ->
    @$el.html(@template(outcome: @outcome()))
    @
