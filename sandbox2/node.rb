#! ruby -Ku -d

# ノード

require "rinda/ring"
require "rinda/tuplespace"
require "config"

class Service
  def hello(ts)
    p ts
    return nil
  end
end

service = Service.new
DRb.start_service(nil, service)

finger = Rinda::RingFinger.new(BROADCAST, PORT)
finger.lookup_ring(5) { |ts|
  p :lookup
  ts.write([:name, :ZeroCloud, DRbObject.new(service), ""], 600)
}

gets
