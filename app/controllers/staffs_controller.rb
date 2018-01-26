class StaffsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_staff, only: [:show, :edit, :update]

  def index
    @staffs = Staff.all
  end

  def show; end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    @staff.password = Rails.application.secrets.staff_password
    @staff.password_confirmation = Rails.application.secrets.staff_password

    if @staff.save
      redirect_to @staff, notice: 'Staff was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @staff.update(staff_params)
      redirect_to staffs_path, notice: 'Staff was successfully updated.'
    else
      render :edit
    end
  end

  private

  def staff_params
    params.require(:staff).permit(:email, :name, :role_id, :organization_id, :address, :phone, :mobile_phone)
  end

  def set_staff
    @staff = Staff.find params[:id]
  end
end
