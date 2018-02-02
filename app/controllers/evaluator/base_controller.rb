class Evaluator::BaseController < Staff::BaseController

  before_action :authorize_for_evaluator


  protected

  def authorize_for_evaluator
    redirect_to evaluator_root_path unless current_staff.evaluator?
  end
end
