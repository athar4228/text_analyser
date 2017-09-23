require 'redis-namespace'

module TextAnalyser

  class Analyser

    def initialize
      @redis = Redis.new(host: host, port: port, thread_safe: true)
      @words_name = Redis::Namespace.new(:wn, redis: @redis)
    end

    def redis
      @redis
    end

    def words_name
      @words_name
    end

    def analyse(sentence)
      analyse_words(sentence)
    end

    def analyse_words(sentence)
      words = sentence_to_words(sentence)
      words.each do |word|
        words_name.incrby(word, 1)
      end
    end

    def sentence_to_words(sentence)
      sentence.split(/[^[[:word:]]]+/)
    end

    private

    def host
      '127.0.0.1'
    end

    def port
      '5555'
    end
  end
end
