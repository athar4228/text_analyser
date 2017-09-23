require 'text_analyser/tcp_server'
require 'socket'

RSpec.describe "TextAnalyser:TcpServer" do

  before(:each) do
    @port = 6677
    @server = TCPServer.open('localhost', @port)
  end

  after(:each) do
    @server.close
  end

  describe 'initialize server' do
    it 'starts server at specified port' do
      expect(@server.addr[1]).to eq(@port)
    end
  end
end
