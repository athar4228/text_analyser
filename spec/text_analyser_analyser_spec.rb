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

    it 'should return instance of Redis NameSpace :cn' do
      expect(subject.characters_name.instance_of? Redis::Namespace).to be(true)
      expect(subject.characters_name.namespace).to eq(:cn)
    end

    it 'should return true if redis-server is running' do
      expect(subject.redis_running?).to eq(true)
    end
  end

  describe 'analyse statement' do
    before(:each) do
      subject.redis.flushall
    end

    it 'should save count for each word' do
      subject.analyse("test with test user")
      expect(subject.words_name.get('test')).to eq('2')
      expect(subject.words_name.get('with')).to eq('1')
      expect(subject.words_name.get('user')).to eq('1')
    end

    it 'should save count for each character' do
      subject.analyse("test with test user")
      expect(subject.characters_name.get('t')).to eq('5')
      expect(subject.characters_name.get('e')).to eq('3')
      expect(subject.characters_name.get('s')).to eq('3')
    end

    it 'splits sentence into words' do
      sentence = 'test with test user.'
      expect(subject.sentence_to_words(sentence).length).to eq(4)
    end
  end
end
