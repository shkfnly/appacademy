Rails.application.routes.draw do



  # get 'users' => 'users#index', as: 'users'
  # post 'users' => 'users#create'
  # get 'users/new' => 'users#new', as: 'new_user'
  # get 'users/:id' => 'users#show', as: 'user'
  # patch 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'

  patch 'contacts/:id' => 'contacts#update'
  resources :contacts, except: [:edit, :update, :index] do
    resources :comments, only: [:index, :create]
  end

  resources :contact_share, only: [:create, :destroy] do
    resources :comments, only: [:index, :create]
  end

  patch 'users/:id' => 'users#update'
  resources :users, except: [:edit, :update] do
    resources :comments, only: [:index, :create]
    resources :contacts, only: :index
  end


end
