#! ruby -Ku

# マネージャ

require "rinda/ring"
require "rinda/tuplespace"
require "config"
require "queue_logger"

logger = QueueLogger.new
logger.info("hoge")
exit

class Manager
  def initialize(port)
    @drb_server  = DRb.start_service(nil, self)
    @ring_space  = Rinda::TupleSpace.new
    @ring_space.write([:name, :ZeroCloud, DRbObject.new(@drb_server.front), ""])
    @ring_server = Rinda::RingServer.new(@ring_space, port)

    @ts = Rinda::TupleSpace.new
  end

  def ts
    return @ts
  end
end

manager = Manager.new(PORT)

gets
