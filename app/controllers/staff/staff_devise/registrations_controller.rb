class Staff::StaffDevise::RegistrationsController < Devise::RegistrationsController
  layout 'application_staff'

  protected

  def update_resource(resource, params)
    if params[:current_password].present?
      resource.update_with_password(params)
    else
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(resource)
    edit_staff_registration_path
  end
end
