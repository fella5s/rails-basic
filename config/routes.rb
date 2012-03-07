Library::Application.routes.draw do
  
  get "sessions/new"

  get "users/new"

  resources :books do
    collection do
      get :search
    end
    resources :reservations, only: [:create, :new] do
      member do
        put :free
      end
    end
  end
  
  root :to => 'books#index'

  get "log_out" => "sessions#destroy", as => "log_out"
  get "log_in" => "", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  resources :users
  recources :sessions
  
end
