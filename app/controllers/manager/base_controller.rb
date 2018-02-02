class Manager::BaseController < Staff::BaseController

  before_action :authorize_for_manager


  protected

  def authorize_for_manager
    redirect_to manager_root_path unless current_staff.manager?
  end
end
