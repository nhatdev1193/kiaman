class Staff::BaseController < ApplicationController
  before_action :authenticate_staff!
  # before_action :require_staff

  protected

  def require_staff
    redirect_to admin_root_path if current_staff.admin?
  end
end
