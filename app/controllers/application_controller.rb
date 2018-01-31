class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(_resource)
    if params[:role_name].nil?
      root_path
    else
      admin_staffs_path
    end
  end

  def after_sign_out_path_for(_resource)
    if params[:role_name].nil?
      root_path
    else
      new_staff_session_url(params[:role_name])
    end
  end
end
