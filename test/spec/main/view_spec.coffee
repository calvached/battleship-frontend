describe 'Main.View', ->
  it 'passes a test!', ->
    x = 1 + 1
    expect(x).toEqual(2)

  it 'renders a template', ->
    view = new Main.View
    view.render()

    expect(view.el.innerHTML).toContain('Battleship')
