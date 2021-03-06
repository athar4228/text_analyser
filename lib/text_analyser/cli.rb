require 'thor'
require_relative 'analyser'
require_relative 'text_formatter'
require_relative 'tcp_server'
require_relative 'stats_handler'

module TextAnalyser
  class CLI < Thor

    TERMINATING_STATEMENTS = %w(exit end)

    desc "Text Analyser", "takes user input and generate stats"

    def init
      @analyser = TextAnalyser::Analyser.new
      if @analyser.redis_running?
        @stats_handler = TextAnalyser::StatsHandler.new(@analyser)
        initialize_tcp_server
        get_user_input
      end
    end

    default_task :init

    no_tasks do

      def initialize_tcp_server
        Thread.new do
          TextAnalyser::TcpServer.new(@stats_handler)
        end
      end

      def get_user_input
        print "Please enter any sentence you want to analyse\r\n"
        print "Please enter exit/end in order to terimate the application \r\n"
        print "# "

        while statement = $stdin.gets.chomp
          if TERMINATING_STATEMENTS.include?(statement.downcase)
            break
          else
             @analyser.analyse(TextAnalyser::TextFormatter.format(statement))
            print "# "
          end
        end
      end
    end

  end
end
