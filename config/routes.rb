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

    resources :organizations, except: [:show] do
      resources :roles, except: [:show]
      get 'roles_permissions', to: 'roles_permissions#index'
      match 'roles_permissions', to: 'roles_permissions#update', via: [:put, :patch], as: 'roles_permissions_update'
    end

    resources :permissions, only: [:index, :edit, :update]
    resources :staffs, except: [:show]

    resources :services, except: [:show]
    resources :steps, except: [:show]
  end

  root to: 'staff/dashboard#index'
end
