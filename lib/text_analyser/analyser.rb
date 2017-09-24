require 'redis-namespace'

module TextAnalyser

  class Analyser

    def initialize
      @redis = Redis.new(host: host, port: port, thread_safe: true)
      @words_name = Redis::Namespace.new(:wn, redis: @redis)
      @characters_name = Redis::Namespace.new(:cn, redis: @redis)
    end

    def redis
      @redis
    end

    def words_name
      @words_name
    end

    def characters_name
      @characters_name
    end

    def redis_running?
      begin
        @redis.ping
        return true
      rescue Exception => e
        e.inspect
        print e.message
        print "\r\n"
        print "Please start resque server using 'redis-server --port #{port}' on given port and start application again\r\n"
        e.message
        return false
      end
    end

    def analyse(sentence)
      analyse_words(sentence)
      analyse_characters(sentence)
    end

    def analyse_words(sentence)
      words = sentence_to_words(sentence)
      words.each do |word|
        words_name.incrby(word, 1)
      end
    end

    def analyse_characters(sentence)
      characters = sentence_to_characters(sentence)
      characters.each do |character|
        @characters_name.incrby(character, 1)
      end
    end

    def sentence_to_words(sentence)
      sentence.split(/[^[[:word:]]]+/)
    end

    def sentence_to_characters(sentence)
      sentence.scan /\w/
    end

    private

    def host
      ENV['REDIS_HOST'] || '127.0.0.1'
    end

    def port
      ENV['REDIS_PORT'] || '5555'
    end
  end
end
