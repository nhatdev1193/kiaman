class Staff::StaffsController < Staff::BaseController
  before_action :set_staff, only: [:edit, :update, :destroy]
  before_action :roles, only: [:new, :edit, :create, :update]

  def index
    @staffs = Staff.with_deleted.includes(:organization)
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      redirect_to staff_staffs_path, notice: 'Staff was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if params[:staff][:password].blank? && staff_params[:password_confirmation].blank?
      params[:staff].delete(:password)
      params[:staff].delete(:password_confirmation)
    end

    if @staff.update(staff_params)
      redirect_to staff_staffs_path, notice: 'Staff was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    msg = if @staff.deleted? && @staff.restore
            'Staff was successfully restored.'
          elsif @staff.destroy
            'Srganization was successfully deleted.'
          end
    redirect_to staff_staffs_path, notice: msg
  end

  private

  def staff_params
    params.require(:staff).permit(:email, :password, :password_confirmation, :name, :organization_id, :address, :phone, :mobile_phone, role_ids: [])
  end

  def set_staff
    @staff = Staff.with_deleted.find params[:id]
  end

  def roles
    @roles = Role.all
  end
end
