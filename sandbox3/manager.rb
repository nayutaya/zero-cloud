#! ruby -Ku -d

# マネージャ

require "rinda/ring"
require "rinda/tuplespace"
require "config"

class Manager
  def initialize
    @drb_server  = DRb.start_service(nil, self)
    @ring_space  = Rinda::TupleSpace.new
    @ring_space.write([:name, :ZeroCloud, DRbObject.new(@drb_server.front), ""])
    @ring_server = Rinda::RingServer.new(@ring_space, PORT)

    @ts = Rinda::TupleSpace.new
  end

  def ts
    p :ts
    return @ts
  end
end

manager = Manager.new

gets
