class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_back fallback_location: root_path, alert: 'Access denied.' unless @user == current_user
  end
end
