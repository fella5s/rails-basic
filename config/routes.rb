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

end
