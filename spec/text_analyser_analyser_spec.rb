require 'redis-namespace'
require 'text_analyser/analyser'

RSpec.describe "TextAnalyser:Analyser" do

  subject { TextAnalyser::Analyser.new }
  before do
    allow_any_instance_of(TextAnalyser::Analyser).to receive(:port).and_return('4444')
    allow_any_instance_of(TextAnalyser::Analyser).to receive(:host).and_return('127.0.0.1')
  end

  describe 'initialise analyser' do
    it 'should return instance of Redis' do
      expect(subject.redis.instance_of? Redis).to be(true)
    end

    it 'should return instance of Redis NameSpace :wn' do
      expect(subject.words_name.instance_of? Redis::Namespace).to be(true)
      expect(subject.words_name.namespace).to eq(:wn)
    end
  end

  describe 'analyse statement' do
    it 'should save count for each word' do
      subject.redis.flushall
      subject.analyse("test with test user")
      expect(subject.words_name.get('test')).to eq('2')
      expect(subject.words_name.get('with')).to eq('1')
      expect(subject.words_name.get('user')).to eq('1')
    end

    it 'splits sentence into words' do
      sentence = 'test with test user.'
      expect(subject.sentence_to_words(sentence).length).to eq(4)
    end
  end
end
