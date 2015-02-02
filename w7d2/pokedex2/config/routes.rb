Rails.application.routes.draw do
  root to: 'static_pages#root'

  resources(
    :pokemon,
    defaults: {format: :json},
    only: [:create, :destroy, :index, :show, :update]
  )
  resources(
    :toys,
    defaults: {format: :json},
    only: [:show, :update]
  )
end
