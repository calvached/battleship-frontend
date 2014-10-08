namespace('Board')

# Models can represent any entity, for example a user
# Collections can represent a collection of entities, for example a collection of users.

class Board.Gameboard extends Backbone.Model
  initialize: ->
    console.log('Model seems to have been initialized...')

  url: 'http://localhost:9393/start_game'
