
# ロガー

require "thread"

class QueueLogger
  def initialize
    @queue  = Queue.new
    @thread = Thread.start {
      while message = @queue.pop
        STDERR.printf("[%s] %s\n", Time.now.strftime("%Y-%m-%d %H:%M:%S"), message)
      end
    }
  end

  def info(message)
    @queue.push(message)
  end
end
