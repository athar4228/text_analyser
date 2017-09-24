require 'socket' # Provides TCPServer and TCPSocket classes

module TextAnalyser
  class TcpServer

    PATH = '/stats'

    def initialize(stats_handler)
      begin
        @server = TCPServer.open(host, port)

        print "--------------------------------------------------------------------------\n"
        print "You can access stats for all the sentences on this url #{path} \r\n"
        print "-------------------------------------------------------------------------- \n"

        @stats_handler = stats_handler
        render_page
      rescue Errno::EADDRINUSE => e
        print "Server is already running. Please access #{path}"
      rescue Errno::ECONNRESET, Errno::EPIPE => e
        print "System is unable to start new server. Please check settings."
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

    def base_url
      "http://#{host}:#{port}"
    end

    def path
      [base_url, PATH].join('')
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
