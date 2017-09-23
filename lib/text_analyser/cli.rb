require 'thor'

module TextAnalyser
  class CLI < Thor

    desc "Text Analyser", "takes user input and generate stats"

    def init
      print "Hello World\r\n"
    end

    default_task :init

  end
end
