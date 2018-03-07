class Staff::StepsController < Staff::BaseController
  before_action :set_step, only: [:edit, :update, :destroy]

  def index
    unless Product.count.positive?
      flash.now[:warning] = "No product available.
                            Click #{view_context.link_to('here', new_staff_product_path)}
                            to create one Product first.".html_safe
    end
    @steps = Step.with_deleted
  end

  def new
    @step = Step.new
  end

  def create
    @step = Step.new(step_params)

    if @step.save
      redirect_to staff_steps_path, notice: 'Step was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @step.update(step_params)
      redirect_to staff_steps_path, notice: 'Step was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    msg = if @step.deleted? && @step.restore
            'Step was successfully restored.'
          elsif @step.destroy
            'Step was successfully deleted.'
          end
    redirect_to staff_steps_path, notice: msg
  end

  private

  def step_params
    params.require(:step).permit(:name, :description, :parent_id, :product_id, :next_step_id, :prev_step_id, :form_id)
  end

  def set_step
    @step = Step.with_deleted.find(params[:id])
  end
end
