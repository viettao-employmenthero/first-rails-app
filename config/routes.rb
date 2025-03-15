Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # rails can detect suitable HTTP method based on verbs
      resources :users, only: %i[create update show destroy]
      resources :posts, only: %i[index create update show destroy]

      # equivalent to:
      # post 'users', to: 'users#create'
      # get 'users/:id', to: 'users#show'
      # put 'users/:id', to: 'users#update'
      # delete 'users/:id', to: 'users#destroy'
    end
  end

  post '/login', to: 'authentication#login'
end
