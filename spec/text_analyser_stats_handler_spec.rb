require 'text_analyser/stats_handler'
require 'text_analyser/text_formatter'
require 'json'

RSpec.describe "TextAnalyser:StatsHandler" do

  before do
    allow_any_instance_of(TextAnalyser::Analyser).to receive(:port).and_return('4444')
    allow_any_instance_of(TextAnalyser::Analyser).to receive(:host).and_return('127.0.0.1')
    @analyser = TextAnalyser::Analyser.new
    @analyser.redis.flushall
  end
  subject { TextAnalyser::StatsHandler.new(@analyser) }

  describe 'initialise Stats Handler' do
    it 'should set instance of analyser' do
      expect(subject.analyser.instance_of? TextAnalyser::Analyser).to be(true)
    end

    it "should have access to word's name space" do
      expect(subject.words_name.instance_of? Redis::Namespace).to be(true)
      expect(subject.words_name.namespace).to eq(:wn)
    end

    it "should have access to character's name space" do
      expect(subject.characters_name.instance_of? Redis::Namespace).to be(true)
      expect(subject.characters_name.namespace).to eq(:cn)
    end

    it 'should return stats based on the details in redis' do
      sentence_1 = "my name is David. David is a good man"
      sentence_2 = "david lives in America. I also live in America"
      @analyser.analyse(TextAnalyser::TextFormatter.format(sentence_1))
      @analyser.analyse(TextAnalyser::TextFormatter.format(sentence_2))
      stats = {"count":18,"top_5_words":["david", "is", "in", "america", "my"],"top_5_characters":["a","i","d","m","v"]}
      response = JSON.parse(subject.stats)
      expect(response["count"]).to be == stats[:count]

      response["top_5_words"].each do |word|
        expect(stats[:top_5_words].include?(word)).to be(true)
      end
      response["top_5_characters"].each do |word|
        expect(stats[:top_5_characters].include?(word)).to be(true)
      end
    end
  end
end
