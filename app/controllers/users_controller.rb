class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Rails.application.secrets.user_password
    @user.password_confirmation = Rails.application.secrets.user_password

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :role_id, :organization_id, :address, :phone, :mobile_phone)
  end

  def set_user
    @user = User.find params[:id]
  end
end
