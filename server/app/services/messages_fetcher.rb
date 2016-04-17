class MessagesFetcher
  def perform
    fetch_messages
    save_and_broadcast_messages
  end

  private

  def fetch_messages
    redis.multi do
      @messages = redis.lrange 'bike_messages', 0, -1
      redis.del 'bike_messages'
    end
  end

  def save_and_broadcast_messages
    @messages.value.each do |raw_message|
      broadcast_message Message.create!(JSON.parse(raw_message))
    end
  end

  def broadcast_message(message)
    ActionCable.server.broadcast('messages_channel', client_id: message.client_id, content: message.content)
  end

  def redis
    @redis ||= Redis.new url: Rails.application.secrets.redis_url
  end

  attr_reader :messages
end
