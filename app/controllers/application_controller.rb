class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    send("#{resource.role_name}_root_path")
  end

  def after_sign_out_path_for(resource)
    if params[:role_name].nil?
      root_path
    else
      new_staff_session_url(params[:role_name])
    end
  end
end
