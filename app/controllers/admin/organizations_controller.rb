class Admin::OrganizationsController < Admin::BaseController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    @organizations = Organization.with_deleted
  end

  def show; end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to [:admin, @organization], notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @organization.update(organization_params)
      redirect_to [:admin, @organization], notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    msg = if @organization.deleted? && @organization.recover
            'Organization was successfully recovered.'
          elsif @organization.destroy
            'Organization was successfully deleted.'
          end
    redirect_to admin_organizations_path, notice: msg
  end

  private

  def organization_params
    params.require(:organization).permit(:parent_id, :name, :level)
  end

  def set_organization
    @organization = Organization.with_deleted.find params[:id]
  end
end
