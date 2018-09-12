Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      post '/login', to: 'users#login'
      get '/current_user', to: 'users#get_current_user'
      get '/users_info/:id', to: 'users#info'

      resources :households, only: [:create, :show]
      patch '/households/:id/:user_id', to: 'households#join'

      resources :events, only: [:create]
      patch '/event_users/:id/accept', to: 'events#accept'
      patch '/event_users/:id/reject', to: 'events#reject'
      patch '/event_users/:id/accept_house', to: 'events#accept_house'
      patch '/event_users/:id/reject_house', to: 'events#reject_house'

      resources :expenses, only: [:create]
      patch '/payments/:id/received', to: 'payments#received'
      patch '/payments/:id/paid', to: 'payments#paid'

      resources :responsibilities, only: [:create]
      post '/responsibilities/:id/create_log', to: 'responsibilities#create_log'

    end
  end
end
