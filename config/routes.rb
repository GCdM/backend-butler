Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      post '/login', to: 'users#login'
      get '/current_user', to: 'users#get_current_user'

      resources :households, only: [:show]
    end
  end
end
