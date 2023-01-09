Rails.application.routes.draw do
  namespace :admin do
    resources :order_units, only: [:index, :create]
  end

  resources :order_units, only: [:show], param: :code do
    resources :orders, only: :create, module: :order_units do
      resource :complete, only: :create, module: :orders
    end
    resources :order_histories, only: :index, module: :order_units
  end
end
