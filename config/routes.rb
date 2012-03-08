Library::Application.routes.draw do
  
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
 
  resources :users
  resources :sessions

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  root :to => 'books#index'
  
end
