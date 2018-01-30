class Staff::StaffsController < Staff::BaseController
  def index
    @staffs = Staff.all
  end
end
