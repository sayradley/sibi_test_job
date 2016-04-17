require_relative './bike.rb'

if ARGV.empty?
  puts 'Please provide a client ID'
  exit 1
end

Bike.new(ARGV[0]).send_message
