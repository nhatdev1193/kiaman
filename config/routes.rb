Rails.application.routes.draw do
  devise_for :staffs,
             path: '/',
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

  # Role.all.map(&:name).each do |role_name|
  namespace 'staff', path: 'staff' do
    get '/dashboard', to: 'dashboard#index'

    resources :staffs
    resources :organizations
    resources :roles_permissions
  end

  root to: 'staff/dashboard#index'
end
