NewsReader::Application.routes.draw do
  namespace :api do
    resources :feeds, only: [:index, :create, :show, :destroy, :new] do
      resources :entries, only: [:index]
    end
  end

  resources :users, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  root to: "static_pages#index"
end
