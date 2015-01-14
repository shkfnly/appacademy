Rails.application.routes.draw do

  resources :users, except: [:index] do
    resources :goals, only: [:show]
    # member do
    #   post 'comment'
    # end
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:show] do
    # member do
    #   post 'comment'
    # end
  end

  resources :comments, only: [:create, :destroy]

  root "goals#index"
end
