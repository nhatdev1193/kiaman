class Staff::ServicesController < Staff::BaseController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = Service.with_deleted
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to staff_services_path, notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to staff_services_path, notice: 'Service was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    msg = if @service.deleted? && @service.restore
            'Service was successfully restored.'
          elsif @service.destroy
            'Service was successfully deleted.'
          end
    redirect_to staff_services_path, notice: msg
  end

  private

  def service_params
    params.require(:service).permit(:name, :description)
  end

  def set_service
    @service = Service.with_deleted.find params[:id]
  end
end
