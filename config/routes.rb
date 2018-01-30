Rails.application.routes.draw do
  devise_for :staffs,
             path: 'staff',
             controllers: {
               sessions: 'staff/staff_devise/sessions',
               passwords: 'staff/staff_devise/passwords',
               registrations: 'staff/staff_devise/registrations'
             },
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'register'
             }

  devise_for :admins,
             path: 'admin',
             controllers: {
               sessions: 'admin/admin_devise/sessions',
               passwords: 'admin/admin_devise/passwords',
               registrations: 'admin/admin_devise/registrations'
             },
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'register'
             }

  namespace :admin do
    resources :staffs

    root to: 'dashboard#index'
  end

  namespace :staff do
    resources :staffs, only: [:index]

    root to: 'dashboard#index'
  end

  resources :visitors, only: [:index]

  root to: 'visitors#index'
end
