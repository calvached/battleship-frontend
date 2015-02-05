namespace('Battleship.Board')

class Battleship.Board.Collection extends Backbone.Collection
  url: 'http://localhost:9393/new'
  model: Battleship.Board.Cell.Model
