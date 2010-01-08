#! ruby -Ku -d

# ノード

require "rinda/ring"
require "rinda/tuplespace"
require "config"

DRb.start_service

finger = Rinda::RingFinger.new(BROADCAST, PORT)
ring_space = finger.lookup_ring_any
sym, name, manager, desc = ring_space.read([:name, :ZeroCloud, DRbObject, nil])
p manager
p manager.ts

gets
