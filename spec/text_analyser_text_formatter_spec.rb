require 'text_analyser/text_formatter'

RSpec.describe "TextAnalyser:TextFormatter" do

  describe 'format sentences' do

    it 'downcase all characters' do
      expect(TextAnalyser::TextFormatter.format("TEST User")).to eq('test user')
    end

    it 'works for nil values as well' do
      expect(TextAnalyser::TextFormatter.format(nil)).to eq('')
    end

    it 'works with integers values as well' do
      expect(TextAnalyser::TextFormatter.format(123)).to eq('123')
    end
  end
end
