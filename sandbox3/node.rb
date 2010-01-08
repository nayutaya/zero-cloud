#! ruby -Ku -d

# ノード

require "rinda/ring"
require "rinda/tuplespace"
require "config"
require "queue_logger"

class Node
  def initialize(port, broadcast)
    @logger  = QueueLogger.new
    @manager = nil

    DRb.start_service
    @logger.info("dRuby server listen on #{DRb.uri}")

    @finger = Rinda::RingFinger.new(broadcast, port)
  end

  def manager
    unless @manager
      ring_space = @finger.lookup_ring_any
      sym, name, manager, desc = ring_space.read([:name, :ZeroCloud, DRbObject, nil])
      @manager = manager
    end
    return @manager
  end
end

node = Node.new(PORT, BROADCAST)

Thread.start {
  loop {
    node.manager.heartbeat("node")
    sleep 5
  }
}

node.manager.ts.write([:job, 1])
#p node.manager.ts.take([:job, Integer])

gets
