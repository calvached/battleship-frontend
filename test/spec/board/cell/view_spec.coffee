describe 'Battleship.Board.Cell.View', ->
  fakeServer = null

  renderView = ->
    _v = new Battleship.Board.Cell.View
      cell: new Battleship.Board.Cell.Model({id: 1})
    _v.render()
    _v

  beforeEach ->
    fakeServer = sinon.fakeServer.create()

  afterEach ->
    fakeServer.restore()

  describe 'when clicking', ->
    it "updates a cell class to 'hit'", ->
      fakeServer.respondWith(
        'POST',
        'http://localhost:9393/board/1',
        [
          200,
          { "Content-Type": "application/json" },
          JSON.stringify({id: 1, status: 'hit'})
        ]
      )

      board = renderView()

      board.$('[data-id=1]').click()
      fakeServer.respond()

      expect(board.$('[data-id=1]').attr('class')).toContain('hit')

    it "updates a cell class to 'miss'", ->
      fakeServer.respondWith(
        'POST',
        'http://localhost:9393/board/1',
        [
          200,
          { "Content-Type": "application/json" },
          JSON.stringify({id: 1, status: 'miss'})
        ]
      )

      board = renderView()

      board.$('[data-id=1]').click()
      fakeServer.respond()

      expect(board.$('[data-id=1]').attr('class')).toContain('miss')

    it "renders a Flash Message when a cell contains the attribute of 'message'", ->
      messageSpy = spyOn(Battleship.FlashMessage.Builder, 'showErrorMessage')
      fakeServer.respondWith(
        'POST',
        'http://localhost:9393/board/1',
        [
          200,
          { "Content-Type": "application/json" },
          JSON.stringify({id: 1, status: 'miss', message: 'Already clicked!'})
        ]
      )

      board = renderView()

      board.$('[data-id=1]').click()
      fakeServer.respond()

      expect(messageSpy).toHaveBeenCalled()
