describe 'Board.View', ->
  it 'sends a cell id to the server', ->
    console.log 'start'
    server = sinon.fakeServer.create()
    console.log server

    server.respondWith('GET','http://localhost:9393/current_board', [200, {"Content-Type": "application/json"}, JSON.stringify({ 1: '', 2: '', 3: '', 4: '' })])

    $.get 'http://localhost:9393/current_board', (data, x, y) =>
      console.log 'In GET request'
      console.log x, y
      console.log data

    console.log server
    server.respond()
    console.log server

 # var server = sinon.fakeServer.create();

 # server.respondWith("GET", "/twitter/api/user.json", [
 #       200,
 #           {"Content-Type": "application/json"},
 #               '[{"id": 0, "tweet": "Hello World"}]'
 # ]);

 # $.get("/twitter/api/user.json", function (data) {
 #       console.log(data); // [{"id":0,"tweet":"Hello World"}]
 # });
 # server.respond();

 # server.restore();
