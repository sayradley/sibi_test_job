Rails.application.routes.draw do
  root 'messages#index'
  mount ActionCable.server => '/cable'
end
