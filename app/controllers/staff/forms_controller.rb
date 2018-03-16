class Staff::FormsController < Staff::BaseController

  before_action :set_dynamic_form, only: [:show, :edit, :update, :destroy]

  # GET /staff/forms
  def index
    @dynamic_forms = Form.all.includes(form_fields: :form_input)
  end

  # GET /staff/forms/:form_id
  def show
    @customer = Customer.new
  end

  # GET /staff/forms/:form_id
  def edit; end

  # PUT /staff/forms/:form_id
  def update; end

  # DELETE /staff/forms/:form_id
  def destroy; end

  # POST /staff/forms/:form_id/execute
  def execute; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dynamic_form
    @dynamic_form = Form.includes(form_fields: :form_input).find(params[:id])
  end
end