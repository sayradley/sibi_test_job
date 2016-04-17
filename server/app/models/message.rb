class Message < ApplicationRecord
  validates :client_id, :content, presence: true
end
