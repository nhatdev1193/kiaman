class Staff::BaseController < ApplicationController
  before_action :authenticate_staff!
  layout 'application_staff'
end
