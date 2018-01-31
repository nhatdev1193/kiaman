Rails.application.routes.draw do
  devise_for :staffs,
             path: ':role_name',
             controllers: {
               sessions: 'staff/staff_devise/sessions',
               passwords: 'staff/staff_devise/passwords',
               registrations: 'staffs/staff_devise/registrations'
             },
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               edit: 'password'
             }

  namespace :admin, path: 'admin' do
    resources :staffs
    resources :organizations
  end

  resources :visitors, only: [:index]

  root to: 'visitors#index'
end
