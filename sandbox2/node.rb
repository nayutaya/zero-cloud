#! ruby -Ku -d

# ノード

require "rinda/ring"
require "rinda/tuplespace"

class Service
  def hello(ts)
    p ts
    return nil
  end
end

DRb.start_service

BROADCAST = ["<broadcast>", "localhost"]
PORT      = 6000


service = Service.new
DRb.start_service(nil, service)
p DRb.uri

#=begin
finger = Rinda::RingFinger.new(BROADCAST, PORT)
p finger
finger.lookup_ring(5) { |ts|
  p :lookup
  ts.write([:name, :ZeroCloud, DRbObject.new(service), ""], 600)
}
#=end

#provider = Rinda::RingProvider.new(:ZeroCloud, DRbObject.new(service), "")
#provider.provide

gets

=begin

DRb.start_service(nil, Startup.new)
p uri = DRb.uri

port = 6000
socket = UDPSocket.open()
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
socket.send(uri, 0, Socket::INADDR_BROADCAST, port)

gets
=end
