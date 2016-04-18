require 'redis'
require 'securerandom'
require 'json'

class Bike
  def initialize(id)
    @id = id
  end

  def send_message
    redis.rpush 'bike_messages', { client_id: @id, content: SecureRandom.hex(250) }.to_json
  end

  def redis
    @redis ||= Redis.new url: 'redis://localhost:6379'
  end
end
