Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, except: [:destroy, :index] do
      resource :comment, only: [:new]
    end
  end
  resources :comments, only: [:create]
end
