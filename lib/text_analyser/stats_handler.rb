require 'json'

module TextAnalyser

  class StatsHandler

    TOP_LIMIT = 5

    def initialize(analyser)
      @analyser = analyser
    end

    def analyser
      @analyser
    end

    def words_name
      analyser.words_name
    end

    def characters_name
      analyser.characters_name
    end

    def stats
      {
        count:  get_total_count,
        top_5_words: get_top_words,
        top_5_characters: get_top_characters
      }.to_json
    end

    def get_total_count
      ordered_words_list.collect{|k| k[1]}.inject(:+).to_i
    end

    def get_top_words
      ordered_words_list.last(TOP_LIMIT).collect{|k| k[0]}.reverse
    end

    def get_top_characters
      ordered_characters_list.last(TOP_LIMIT).collect{|k| k[0]}.reverse
    end

    def ordered_words_list
      output = {}
      words_name.keys('*').each do |key|
        output[key] = words_name.get(key).to_i
      end
      output.sort_by { |key, value| value }
    end

    def ordered_characters_list
      output = {}
      characters_name.keys('*').each do |key|
        output[key] = characters_name.get(key).to_i
      end
      output.sort_by { |key, value| value }
    end
  end

end
