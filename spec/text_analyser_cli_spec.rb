require 'stringio'

RSpec.describe "TextAnalyser:CLI" do
  describe 'display User Input' do
    def capture_name(name)
      $stdin = StringIO.new("Test User\n")
      $stdin.gets.chomp
    end

    after do
      $stdin = STDIN
    end

    it "should be equal to user's input" do
      statement = "Test User"
      expect(capture_name(statement)).to be == statement
    end
  end
end
