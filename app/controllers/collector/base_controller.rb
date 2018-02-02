class Collector::BaseController < Staff::BaseController

  before_action :authorize_for_collector


  protected

  def authorize_for_collector
    redirect_to collector_root_path unless current_staff.collector?
  end
end
