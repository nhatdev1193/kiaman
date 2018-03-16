class Staff::BaseController < ApplicationController
  include ErrorHandlers
  before_action :authenticate_staff!,
                :set_current_staff_permissions,
                :authorize_current_staff!

  layout 'application_staff'

  protected

  def set_current_staff_permissions
    if current_staff.has_role?([:admin])
      @current_staff_permissions = ['admin']
    else
      @current_staff_permissions ||= current_staff.permissions
    end

    @current_staff_permissions
  end

  def authorize_current_staff!
    return true if @current_staff_permissions.include?('admin')

    unless @current_staff_permissions.map(&:controller_path).include?(controller_path) &&
           @current_staff_permissions.map(&:action_name).include?(action_name)
      sign_out
      raise UnauthorizedError
    end
  end
end
