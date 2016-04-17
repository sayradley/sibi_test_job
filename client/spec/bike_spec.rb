require 'fakeredis'
require 'fakeredis/rspec'
require_relative '../bike.rb'

describe Bike do
  let!(:redis) { Redis.new } # fake redis

  subject { described_class.new(1) }

  before do
    allow(SecureRandom).to receive(:hex).with(500).and_return('test')
    allow(Redis).to receive(:new).and_return(redis)
  end

  describe '#send_message' do
    it 'sends a random message to redis' do
      subject.send_message
      expect(redis.lrange('bike_messages', 0, -1)).to match_array([{ client_id: 1, content: 'test' }.to_json])
    end
  end
end
