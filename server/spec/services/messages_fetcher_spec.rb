require 'rails_helper'

describe MessagesFetcher do
  before do
    redis = Redis.new # fake redis
    redis.rpush 'bike_messages', { client_id: 'abc', content: 'message1' }.to_json
    redis.rpush 'bike_messages', { client_id: 'def', content: 'message2' }.to_json
  end

  it 'creates 2 messages fetched from redis' do
    expect do
      subject.perform
    end.to change { Message.count }.by(2)
  end

  it 'creates messages fetched from redis with a valid data' do
    subject.perform
    expect(Message.pluck(:client_id, :content)).to eq([['abc', 'message1'], ['def', 'message2']])
  end

  it 'broadcast all messages' do
    expect(ActionCable.server).to receive(:broadcast).with('messages_channel', client_id: 'abc', content: 'message1')
    expect(ActionCable.server).to receive(:broadcast).with('messages_channel', client_id: 'def', content: 'message2')
    subject.perform
  end
end
