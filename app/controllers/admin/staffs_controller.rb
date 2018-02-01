class Admin::StaffsController < Admin::BaseController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  def index
    @staffs = Staff.with_deleted
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
      redirect_to [:admin, @staff], notice: 'Staff was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @staff.update(staff_params)
      redirect_to [:admin, @staff], notice: 'Staff was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    msg = if @staff.deleted? && @staff.recover
            'Staff was successfully recovered.'
          elsif @staff.destroy
            'Srganization was successfully deleted.'
          end
    redirect_to admin_staffs_path, notice: msg
  end

  private

  def staff_params
    params.require(:staff).permit(:email, :name, :role_id, :organization_id, :address, :phone, :mobile_phone)
  end

  def set_staff
    @staff = Staff.with_deleted.find params[:id]
  end
end
