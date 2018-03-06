class Staff::FormsController < Staff::BaseController
  def view
    @form = Form.includes(form_fields: :form_input).find(params[:id])
  end

  def execute; end
end