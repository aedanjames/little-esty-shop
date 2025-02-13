  Rails.application.routes.draw do

  get '/', to: 'application#welcome'
  
  resources :merchants, only: [:show, :index, :update, :post], module: :merchant do
    resources :discounts, only: [:index, :show, :edit, :update, :create, :new, :destroy]
    resources :invoices, only: [:index, :show, :update]
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
  end
  namespace :admin, only: [:index, :show, :edit, :update, :new, :create], module: :admin do
    resources :dashboard, only: [:index]
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :update]
  end
end
