class Sale::BaseController < Staff::BaseController

  before_action :authorize_for_sale


  protected

  def authorize_for_sale
    redirect_to sale_root_path unless current_staff.sale?
  end
end
