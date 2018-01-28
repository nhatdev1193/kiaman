Rails.application.routes.draw do
  ROLE_NAMES = Role.pluck :name

  ROLE_NAMES.each do |role|
    namespace role.to_sym do
      devise_for :staffs, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

      resources :staffs
      resources :visitors, only: [:index]
      resources :pages, only: [] do
        get 'about', on: :collection
      end

      root to: 'visitors#index'
    end
  end
end
