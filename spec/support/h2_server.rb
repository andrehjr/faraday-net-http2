require 'logger'

class H2Server

  attr_accessor :on_req

  def initialize(port = nil, log_level = Logger::INFO)
    @port          = port
    @server        = nil
    @server_thread = nil
    @threads       = []
    @logger = Logger.new(STDOUT)
    @logger.level = log_level
  end

  def listen
    @server = TCPServer.new(@port)

    @server_thread = Thread.start do
      loop do
        Thread.start @server.accept do |socket|
          @threads << Thread.current

          serve_http2(socket)
        end
      end
    end
  end

  def stop
    exit_thread(@server_thread)
    @threads.each { |t| exit_thread(t) }

    @server.close

    @server        = nil
    @ssl_context   = nil
    @listen_thread = nil
    @threads       = []
  end

  private

  def serve_http2(socket)
    conn = HTTP2::Server.new

    conn.on(:frame) { |bytes| socket.write(bytes) }
    conn.on(:stream) do |stream|
      stream.on(:headers) { |head| @logger.debug(head.inspect) }
      stream.on(:data) { |d| @logger.debug(data.inspect); req.body << d }
      stream.on(:half_close) do
        @logger.debug "client closed its end of the stream"
        response = "Hello HTTP 2.0!"

        stream.headers({
          ':status'        => '200',
          'content-length' => response.bytesize.to_s,
          'content-type'   => 'text/plain',
        }, end_stream: false)

        stream.data(response[0, 5], end_stream: false)
        stream.data(response[5..-1] || "", end_stream: true)
      end
    end

    while !socket.closed? && !(socket.eof? rescue true)
      data = socket.readpartial(16_384)

      begin
        conn << data
      rescue StandardError => e
        puts "#{e.class} exception: #{e.message} - closing socket."
        puts e.backtrace
        socket.close
      end
    end
  end

  def exit_thread(thread)
    return unless thread
    thread.exit
    thread.join
  end
end
