namespace('Board')

# This view news up the Board model so that it can get a board and generate the HTML to display it.

class Board.View extends Backbone.View
  template: JST['app/scripts/board/view_template.ejs']

  render: ->
    @$el.html(@template())

  gameboard: ->
    board = new Board.Gameboard
    board.fetch()

  appendGridCells: ->
    console.log(@gameboard())
    console.log('appending grid cells')
    #@$el.append('<div id=0 class=hidden_card></div>')

# Need to figure out how I want to display a board
#
# var images = [];
#
# for (var i = 1; i <= 50; i++) {
#      images.push('<img src="lq/'+i+'.jpg" class="image-'+i+'"/>');
# }
#
# $('.imagecontainer').append(images.join('\n'));
