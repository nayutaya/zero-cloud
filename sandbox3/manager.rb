#! ruby -Ku -d

# マネージャ

require "rinda/ring"
require "rinda/tuplespace"
require "config"

class Service
  def hello
    p :hello
    return nil
  end
end

drb_server  = DRb.start_service(nil, Service.new)
ring_space  = Rinda::TupleSpace.new
ring_space.write([:name, :ZeroCloud, DRbObject.new(drb_server.front), ""])
ring_server = Rinda::RingServer.new(ring_space, PORT)


job_ts = Rinda::TupleSpace.new

gets
