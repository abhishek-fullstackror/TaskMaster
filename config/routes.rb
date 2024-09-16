Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'testing_purpose'
    end
    member do
      get 'find_user_email'
      post 'assign'
    end
  end
  devise_for :users
  resources :assigned_tasks

  resource :example, constraints: -> { Rails.env.development? }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'
end
