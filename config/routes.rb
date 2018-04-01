Rails.application.routes.draw do
  devise_for :staffs,
             path: '/staff',
             controllers: {
               sessions: 'staff/staff_devise/sessions',
               passwords: 'staff/staff_devise/passwords',
               registrations: 'staff/staff_devise/registrations'
             },
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               edit: '',
               registration: 'profile'
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

    resources :services, except: [:show] do
      resources :steps, except: [:show]
    end
    resources :organizations, except: [:show]
    resources :roles, except: [:show]
    resources :permissions, except: [:show]
    get 'roles_permissions', to: 'roles_permissions#index'
    match 'roles_permissions', to: 'roles_permissions#update', via: [:put, :patch], as: 'roles_permissions_update'
    resources :products, except: [:show]
    resources :steps, except: [:show]

    # People routes
    post 'people/create_normal_prospect', to: 'people#create_normal_prospect'
    get 'people/fast_prospect', to: 'people#new_fast_prospect'
    post 'people/fast_prospect', to: 'people#create_fast_prospect'

    resources :people, only: [:index, :show, :edit, :update] do
      collection do
        post '/nic_check', to: 'people#nic_check'
      end

      resources :documents, only: [:show] do
        collection do
          post '/', to: 'documents#upload_documents'
        end

        member do
          get '/download', to: 'documents#download_document'
        end
      end
    end

    resources :forms do
      member do
        post :execute
      end
    end
    resource :venues, only: [] do
      get :districts
      get :wards
    end
  end

  root to: 'staff/dashboard#index'
end
