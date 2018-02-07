class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    staff_dashboard_url
  end

  def after_sign_out_path_for(resource)
    new_staff_session_url
  end
end
