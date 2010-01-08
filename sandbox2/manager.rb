#! ruby -Ku -d

# マネージャ

require "rinda/ring"
require "rinda/tuplespace"
require "config"

DRb.start_service


p ring_ts     = Rinda::TupleSpace.new
p ring_server = Rinda::RingServer.new(ring_ts, PORT)

ts = Rinda::TupleSpace.new

p service = ring_ts.read([:name, :ZeroCloud, DRbObject, nil])
p service[2]
p service[2].hello(ts)

gets
