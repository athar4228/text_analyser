require 'socket' # Provides TCPServer and TCPSocket classes

module TextAnalyser
  class TcpServer

    PATH = '/stats'

    def initialize
      begin
        @server = TCPServer.open(host, port)
        render_page
      rescue Errno::ECONNRESET, Errno::EADDRINUSE, Errno::EPIPE => e
        print "System is unable to connect to 'http://#{host}:#{port}'. Please check settings\r\n"
      end
    end

    def render_page
      loop do
        Thread.start(@server.accept) do |socket|
          request = socket.gets(PATH)
          response = "Text Analyser"
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
