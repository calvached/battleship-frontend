describe 'Battleship.Outcome.View', ->
  renderView = (outcome) ->
    _v = new Battleship.Outcome.View({ gameOutcome: outcome })
    _v.render()
    _v

  it 'displays a win', ->
    view = renderView('You win')

    expect(view.$el.html()).toContain('You win')

  it 'displays a loss', ->
    view = renderView('You lose')

    expect(view.$el.html()).toContain('You lose')
