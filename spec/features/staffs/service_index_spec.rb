feature 'Show services list' do
  include_context 'a logged in admin'

  before do
    @services = create_list :service, 5
  end

  scenario 'admin see services list' do
    visit staff_services_path

    expect(page).to have_content @services.first.name
  end
end
