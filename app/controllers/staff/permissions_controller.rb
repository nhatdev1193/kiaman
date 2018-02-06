class Staff::PermissionsController < Staff::BaseController
  before_action :set_permission, only: [:edit, :update, :destroy]

  # GET /permissions
  def index
    @permissions = Permission.all
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  def edit; end

  # POST /permissions
  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      redirect_to staff_permissions_path, notice: 'Permission was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /permissions/1
  def update
    if @permission.update(permission_params)
      redirect_to staff_permissions_path, notice: 'Permission was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /permissions/1
  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to permissions_url, notice: 'permission was successfully destroyed.' }
      format.json { head :no_content }
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
