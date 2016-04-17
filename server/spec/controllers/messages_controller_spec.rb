require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    let!(:message_one) { FactoryGirl.create(:message) }
    let!(:message_two) { FactoryGirl.create(:message) }

    before { get :index }

    it 'assigns all messages to `@messages` var' do
      expect(assigns(:messages)).to eq([message_one, message_two])
    end
  end
end
