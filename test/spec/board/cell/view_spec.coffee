describe 'Battleship.Board.Cell.View', ->
  renderView = ->
    _v = new Battleship.Board.Cell.View
      cell: new Battleship.Board.Cell.Model({id: 1})
    _v.render()
    _v

  describe 'when clicking', ->
    it "updates a cell class to 'hit' and removes 'clickable'", ->
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
      expect(board.$('[data-id=1]').attr('class')).not.toContain('clickable')
      fakeServer.restore()

    it "updates a cell class to 'miss' and removes 'clickable'", ->
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
      expect(board.$('[data-id=1]').attr('class')).not.toContain('clickable')
      fakeServer.restore()
