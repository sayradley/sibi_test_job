Rails.application.routes.draw do
  root 'messages#index'
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
