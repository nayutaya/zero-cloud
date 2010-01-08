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

DRb.start_service



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
