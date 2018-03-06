class Staff::FormsController < Staff::BaseController
  def view
    @form = Form.find(params[:id])
  end

  def execute; end
end