class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :role_slug

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_url
    else
      staff_root_url
    end
  end

  def after_sign_out_path_for(_resource)
    if ['admin'].include?(@role_slug)
      new_admin_session_url
    else
      new_staff_session_url
    end
  end

  def role_slug
    @role_slug = request.path.split('/').reject(&:empty?).first || 'staff'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
