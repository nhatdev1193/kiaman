class Staff::BaseController < ApplicationController

  include ErrorHandlers
  before_action :authenticate_staff!, :authorize_current_staff!

  layout 'application_staff'


  protected

  def authorize_current_staff!
    return true if current_staff.has_role?([:admin])

    staff_permissions = current_staff.permissions
    unless staff_permissions.pluck(:controller_path).include?(controller_path) && staff_permissions.pluck(:action_name).include?(action_name)
      sign_out
      raise UnauthorizedError
    end
  end
end
