class Staff::BaseController < ApplicationController

  before_action :authenticate_staff!

  layout 'application_staff'

  def pundit_user
    current_staff
  end
end
