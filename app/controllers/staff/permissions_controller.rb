class Staff::PermissionsController < Staff::BaseController
  before_action :set_permission, only: [:edit, :update]

  # GET /organization/:organization_id/permissions
  def index
    @permissions = Permission.all
  end

  # GET /organization/:organization_id/permissions/1/edit
  def edit; end

  # PATCH/PUT /organization/:organization_id/permissions/1
  def update
    if @permission.update(permission_params)
      redirect_to staff_permissions_path, notice: 'Permission was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def permission_params
    params.require(:permission).permit(:name, :level)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_permission
    @permission = Permission.find(params[:id])
  end
end
