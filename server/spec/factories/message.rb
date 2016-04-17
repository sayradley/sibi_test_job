FactoryGirl.define do
  factory :message do
    sequence(:client_id) { |n| "client_#{n}" }
    content { SecureRandom.hex(500) }
  end
end
