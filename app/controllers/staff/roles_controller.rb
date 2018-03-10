class Staff::RolesController < Staff::BaseController
  before_action :set_organization
  before_action :set_role, only: [:edit, :update, :destroy]

  # GET /roles
  def index
    @search_conditions = params[:search_conditions]
    @roles = @organization.roles.search(params[:search_conditions])
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit; end

  # POST /roles
  def create
    @role = @organization.roles.new(role_params)

    if @role.save
      redirect_to staff_organization_roles_path(@organization), notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      redirect_to staff_organization_roles_path(@organization), notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /roles/1
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to staff_roles_url, notice: 'role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:parent_id, :name, :level)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
