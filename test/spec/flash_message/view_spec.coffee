describe 'Battleship.FlashMessage.View', ->
  renderView = (message, styleType) ->
    _v = new Battleship.FlashMessage.View({ message: message, styleType: styleType })
    _v.render()
    _v

  it 'displays a message', ->
    view = renderView('You win!', 'win')

    expect(view.$el.html()).toContain('You win!')

  it 'renders a specific style if given one', ->
    view = renderView('You win!', 'win')

    expect(view.$('div').attr('class')).toContain('win')
