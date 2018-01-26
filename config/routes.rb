Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :staffs, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :staffs
end
