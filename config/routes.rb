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

  Role.all.map(&:name).each do |role_name|
    namespace role_name, path: role_name do
      # Routes only for admin
      case role_name
        when 'admin'
          resources :staffs
          resources :organizations
      end

      root to: 'dashboard#index'
    end
  end
end
