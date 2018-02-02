class Admin::BaseController < ApplicationController
  before_action :authenticate_staff!
  before_action :require_admin

  protected

  def require_admin
    redirect_to admin_root_path unless current_staff.admin?
  end
end
