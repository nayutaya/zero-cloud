#! ruby -Ku -d

# マネージャ

require "rinda/ring"
require "rinda/tuplespace"

DRb.start_service

PORT = 6000

p ring_ts     = Rinda::TupleSpace.new
p ring_server = Rinda::RingServer.new(ring_ts, PORT)

ts = Rinda::TupleSpace.new

p service = ring_ts.read([:name, :ZeroCloud, DRbObject, nil])
p service[2]
p service[2].hello(ts)

gets

=begin
port = 6000
socket = UDPSocket.open()
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
socket.bind(Socket::INADDR_ANY, port)

ts = Rinda::TupleSpace.new

thread = Thread.new {
  loop {
    uri, info = socket.recvfrom(128)
    p service = DRbObject.new_with_uri(uri)
    p service.hello(ts)
  }
}

p thread

gets

thread.kill
=end
