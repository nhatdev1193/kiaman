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

  namespace 'staff', path: 'staff' do
    get '/dashboard', to: 'dashboard#index'

    resources :staffs, except: [:show]
    resources :organizations, except: [:show]
    resources :roles_permissions
    resources :services, except: [:show]
    resources :steps, except: [:show]
  end

  root to: 'staff/dashboard#index'
end
