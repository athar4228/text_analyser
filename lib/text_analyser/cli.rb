require 'thor'
require_relative 'analyser'

module TextAnalyser
  class CLI < Thor

    TERMINATING_STATEMENTS = %w(exit end)

    desc "Text Analyser", "takes user input and generate stats"

    def init
      @analyser = TextAnalyser::Analyser.new
      get_user_input
    end

    default_task :init

    no_tasks do
      def get_user_input
        print "Please enter any sentence \r\n"
        print "# "

        while statement = $stdin.gets.chomp
          if TERMINATING_STATEMENTS.include?(statement.downcase)
            break
          else
            @analyser.analyse statement
            print "# "
          end
        end
      end
    end

  end
end
