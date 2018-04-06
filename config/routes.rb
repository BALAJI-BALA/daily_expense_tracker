Rails.application.routes.draw do
  resources :expenses
  devise_for :users
  get 'dashboard/index'
  get 'dashboard/add_expense'
  post 'dashboard/add_expense'
  root :to => "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
