#! ruby -Ku

# マネージャ

require "rinda/ring"
require "rinda/tuplespace"
require "config"
require "queue_logger"

class Manager
  def initialize(port)
    @logger = QueueLogger.new
    @ts     = Rinda::TupleSpace.new

    @drb_server = DRb.start_service(nil, self)
    @logger.info("dRuby server listen on #{DRb.uri}")

    @ring_space = Rinda::TupleSpace.new
    @ring_space.write([:name, :ZeroCloud, DRbObject.new(@drb_server.front), ""])
    @logger.info("registered service")

    @ring_server = Rinda::RingServer.new(@ring_space, port)
    @logger.info("Ring server listen")
  end

  def ts
    return @ts
  end

  def heartbeat(name)
    @logger.info("heartbeat from #{name}")
    return true
  end
end

manager = Manager.new(PORT)

gets
