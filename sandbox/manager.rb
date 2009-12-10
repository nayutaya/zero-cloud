#! ruby -Ku

require "socket"
require "drb/drb"

Thread.abort_on_exception = true


port = 6000

socket = UDPSocket.open()
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
socket.bind(Socket::INADDR_ANY, port)
puts "bind"

loop {
  puts "wait"
  uri, addr = socket.recvfrom(100)
  p [uri, addr]
  puts "recv"
  p thread = Thread.new {
    puts "connecting"
    p service = DRbObject.new_with_uri(uri)
    puts "connected"
    p service.test
  }
  p thread.join
}
