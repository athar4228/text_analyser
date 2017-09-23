require 'socket' # Provides TCPServer and TCPSocket classes

module TextAnalyser
  class TcpServer

    PATH = '/stats'

    def initialize(stats_handler)
      begin
        @server = TCPServer.open(host, port)
        @stats_handler = stats_handler
        render_page
      rescue Errno::ECONNRESET, Errno::EADDRINUSE, Errno::EPIPE => e
        print "System is unable to load the page using url 'http://#{host}:#{port}'. Please check settings\r\n"
      end
    end

    def render_page
      loop do
        Thread.start(@server.accept) do |socket|
          request = socket.gets(PATH)
          response = @stats_handler.stats
          socket.print "HTTP/1.1 200 OK\r\n" +
                       "Content-Type: text/plain\r\n" +
                       "Content-Length: #{response.bytesize}\r\n" +
                       "Connection: close\r\n"

          socket.print "\r\n"
          socket.print response

          socket.close
        end
      end
    end

    private

    def host
      ENV['TCP_HOST'] || 'localhost'
    end

    def port
      ENV['TCP_PORT'] || '8080'
    end

  end
end
