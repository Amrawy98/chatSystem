Rails.application.routes.draw do
  get 'messages/index'
  get 'chats/index'
  # get 'apps', to: 'apps#index'
  resources :apps
  resources :chats
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
