class Admin::BaseController < Staff::BaseController

  before_action :authorize_for_admin


  protected

  def authorize_for_admin
    redirect_to admin_root_path unless current_staff.admin?
  end
end
