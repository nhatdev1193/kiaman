class Staff::RolesPermissionsController < Staff::BaseController
  before_action :set_organization

  # GET /organizations/:organization_id/roles_permissions
  def index
    @roles = @organization.roles
                          .without_admin_role
                          .includes(:permissions)
    @permissions = Permission.all
  end

  # PATCH/PUT /organizations/:organization_id/roles_permissions
  def update
    initial_roles_permissions_vals = roles_permissions_params[:initial_roles_permissions_vals].split(',')
    selected_roles_permissions_vals = roles_permissions_params[:selected_roles_permissions_vals].split(',')

    # Filter records which will be deleted
    deleted_records = initial_roles_permissions_vals.reject { |v| selected_roles_permissions_vals.include?(v) }

    # Filter new records which will be added
    new_records = selected_roles_permissions_vals.reject{ |v| initial_roles_permissions_vals.include?(v) }

    #
    # Database operations
    #

    # Delete records
    RolePermission.transaction do
      deleted_records.map do |str|
        role_id, permission_id = str.split('_')
        RolePermission.find_by(role_id: role_id.to_i, permission_id: permission_id.to_i).delete
      end

      # Create new records
      new_records.map do |str|
        role_id, permission_id = str.split('_')
        RolePermission.create!(role_id: role_id.to_i, permission_id: permission_id.to_i)
      end
    end

    redirect_to staff_organizations_path, notice: 'Roles & permissions successfully updated.'
  end

  private

  def roles_permissions_params
    params.permit(:initial_roles_permissions_vals, :selected_roles_permissions_vals)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
