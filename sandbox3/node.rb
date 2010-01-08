#! ruby -Ku -d

# ノード

require "rinda/ring"
require "rinda/tuplespace"
require "config"

DRb.start_service

finger = Rinda::RingFinger.new(BROADCAST, PORT)
finger.lookup_ring(5) { |ts|
  p ts
  p service = ts.read([:name, :ZeroCloud, DRbObject, nil])
  p service[2]
  p service[2].ts
}

gets
