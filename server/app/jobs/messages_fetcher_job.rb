class MessagesFetcherJob < ActiveJob::Base
  queue_as :default

  def perform
    messages_fetcher = MessagesFetcher.new

    loop do
      messages_fetcher.perform
      sleep 5
    end
  end
end
