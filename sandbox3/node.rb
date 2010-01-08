#! ruby -Ku -d

# ノード

require "rinda/ring"
require "rinda/tuplespace"
require "config"

class Node
  def initialize(port, broadcast)
    DRb.start_service
    @finger = Rinda::RingFinger.new(broadcast, port)
  end

  def manager
    ring_space = @finger.lookup_ring_any
    sym, name, manager, desc = ring_space.read([:name, :ZeroCloud, DRbObject, nil])
    return manager
  end
end

node = Node.new(PORT, BROADCAST)
p node.manager

gets
