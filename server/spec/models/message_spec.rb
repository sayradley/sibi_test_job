require 'rails_helper'

describe Message do
  it { should validate_presence_of :client_id }
  it { should validate_presence_of :content }
end
