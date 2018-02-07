feature 'Destroy service' do
  include_context 'a logged in admin'

  before do
    @service = create :service

    visit staff_services_path
  end

  scenario 'admin delete the service' do
    find_all('a', text: 'Delete').last.click

    expect(page).to have_content 'Restore'
  end
end
