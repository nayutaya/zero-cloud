#! ruby -Ku

require "socket"

port = 6000

socket = UDPSocket.open()
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
socket.bind(Socket::INADDR_ANY, port)

loop do
  p socket.recvfrom(20)
end
