#! ruby -Ku

require "socket"

port = 6000

socket = UDPSocket.open()
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
p socket.send("Hello\n", 0, Socket::INADDR_BROADCAST, port)
