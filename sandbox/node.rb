#! ruby -Ku

require "socket"
require "thread"
require "drb/drb"

Thread.abort_on_exception = true


class Service
  def test
    p :test
    return rand(100)
  end
end

log = Queue.new
logging_thread = Thread.new {
  log.push("logging thread start.")

  while message = log.pop
    STDERR.printf("[%s] %s\n", Time.now.strftime("%Y-%m-%d %H:%M:%S"), message)
  end
}

uri = nil
drb_thread = Thread.new {
  log.push("dRuby thread start.")
  DRb.start_service(nil, Service.new)
  uri = DRb.uri
  log.push("URI: #{uri}")
  DRb.thread.join
}

port = 6000
socket = UDPSocket.open()
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
watch_thread = Thread.new {
  log.push("watch thread start.")
  loop {
    socket.send(uri, 0, Socket::INADDR_BROADCAST, port) if uri
    log.push("ping")
    sleep(1.0)
  }
}

drb_thread.join
