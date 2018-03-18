class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :mobile_phone, :password, :password_confirmation])
  end

  def after_sign_in_path_for(resource)
    staff_dashboard_url
  end

  def after_sign_out_path_for(resource)
    new_staff_session_url
  end

  def ajax_redirect_to(url, notice = nil)
    if notice
      flash[:notice] = notice
    end

    head 302, x_ajax_redirect_url: url
  end
end
