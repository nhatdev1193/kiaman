class Staff::BaseController < ApplicationController
  before_action :authenticate_staff!
end
