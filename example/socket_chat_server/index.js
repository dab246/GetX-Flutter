const express = require("express");
var http = require("http");
const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

app.use(express.json());
var clients = {};

io.on("connection", (socket) => {
  console.log("connected");
  console.log(socket.id, "has joined");

  socket.on("sign_in", (id) => {
    console.log(id);
    clients[id] = socket;
    console.log(clients);
  });

  socket.on("message", (msg) => {
    console.log(msg);
    let targetId = msg.targetId;
    if (clients[targetId]) clients[targetId].emit("message", msg);
  });

  socket.on('connect', function () {
    console.log('client connect')
  })

  socket.on('disconnect', function () {
    console.log('client disconnect...', socket.id)
    // handleDisconnect()
  })

  socket.on('error', function (err) {
    console.log('received error from client:', socket.id)
    console.log(err)
  })
});

var server_port = process.env.PORT || 8000;
server.listen(server_port, function (err) {
  if (err) throw err
  console.log('Listening on port %d', server_port);
});
