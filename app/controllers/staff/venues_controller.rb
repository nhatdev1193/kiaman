class Staff::VenuesController < Staff::BaseController
  before_action :initialize_venue_service, only: [:districts, :wards]

  def districts
    render json: @venue_service.fetch_districts(params[:city_id])
  end

  def wards
    render json: @venue_service.fetch_wards(params[:district_id])
  end

  private

  def initialize_venue_service
    @venue_service = VenueService.new
  end
end
