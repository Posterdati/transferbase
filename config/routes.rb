Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register', sign_up: 'cmon_let_me_in' }
  root to: 'transactions#index'

  resources :transactions, only: [:index, :new, :create] 
end
