namespace('Game')

class Game.BoardCollection extends Backbone.Collection
  url: 'http://localhost:9393/new'
  model: Game.CellModel
