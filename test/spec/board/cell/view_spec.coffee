describe 'Battleship.Board.Cell.View', ->
  renderView = ->
    _v = new Battleship.Board.Cell.View
      cell: new Battleship.Board.Cell.Model({id: 1})
      msgElem: '<div></div>'
    _v.render()
    _v

  describe 'when clicking', ->
    it "updates a cell class to 'hit'", ->
      fakeServer = sinon.fakeServer.create()
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
      fakeServer.restore()

    it "updates a cell class to 'miss'", ->
      fakeServer = sinon.fakeServer.create()
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
      fakeServer.restore()

    it "renders a Flash Message when a cell contains the attribute of 'message'", ->
      messageSpy = spyOn(Battleship.FlashMessage, 'View').andReturn(new Backbone.View)
      fakeServer = sinon.fakeServer.create()
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
