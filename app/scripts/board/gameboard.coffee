namespace('Board')

class Board.Gameboard extends Backbone.Model
  url: 'http://localhost:9393/current_board'
