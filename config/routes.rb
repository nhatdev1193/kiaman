Rails.application.routes.draw do
  devise_for :staffs, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  # Staff Routes
  # ====================================
  namespace :staff, url: '/' do

  end

  # Admin Routes
  # ====================================
  namespace :admin, url: '/admin' do
    resources :staffs

    root to: 'visitors#index'
  end
end
