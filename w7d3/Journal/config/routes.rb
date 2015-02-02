Rails.application.routes.draw do
  root to: 'static#root'
  resources :posts, defaults: {format: :json}
end
