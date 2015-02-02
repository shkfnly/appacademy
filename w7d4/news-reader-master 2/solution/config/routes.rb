NewsReader::Application.routes.draw do
  resource :session
  resources :users
  namespace :api do
    resources :feeds, only: [:index, :create, :show] do
      resources :entries, only: [:index]
    end
    resources :entries, only: [:show]
  end

  root to: "static_pages#index"
end
