const express = require("express");
const socketIO = require("socket.io");
const http = require("http");
const app = express();

var PORT = process.env.PORT || 8000;

const server = http.createServer(app);
const io = socketIO(server);

// This map has all users connected
const userMap = new Map();

function addUser(key_user_id, val) {
    userMap.set(key_user_id, val);
}

function sendBackToClient(socket, event, message) {
	socket.emit(event, stringifyJson(message));
}

function sendMessageToSocketId(socket, to_user_socket_id, event, message) {
	socket.to(`${to_user_socket_id}`).emit(event, stringifyJson(message));
}

function removeUser(socket_id) {
	console.log('Deleting user with socket id: ' + socket_id);
	let toDeleteUser;
	for (let key of userMap) {
		// index 1, returns the value for each map key
		let userMapValue = key[1];
		if (userMapValue.socket_id == socket_id) {
			toDeleteUser = key[0];
		}
	}
	console.log('Deleting User: ' + toDeleteUser);
	if (undefined != toDeleteUser) {
		userMap.delete(toDeleteUser);
	}
	console.log(userMap);
}

// Always stringify to create proper json before sending.
function stringifyJson(data) {
	return JSON.stringify(data);
}

io.on('connection', socket => {
  console.log('---------------------------------------');
  console.log('Connected => Socket ID ' + socket.id + ', User: ' + JSON.stringify(socket.handshake.query));

  var from_user_id = socket.handshake.query.from;
  // Add to Map
  let userMapVal = { socket_id: socket.id };
  addUser(from_user_id, userMapVal);

  console.log(userMap);

  socket.on('message', function (chat_message) {
    console.log('Message: ' + stringifyJson(chat_message));

    socket.emit('message_chat', stringifyJson(chat_message));
  });

  socket.on('disconnect', function () {
    console.log('Disconnected ' + socket.id);
    removeUser(socket.id);
    socket.removeAllListeners('message');
    socket.removeAllListeners('disconnect');
  });

});

server.listen(PORT, () => {
  console.log(`App started at port ${PORT}`);
});