feature 'Add new service' do
  include_context 'a logged in admin'

  before do
    visit staff_services_path

    click_link 'New service'
  end

  scenario 'admin add new service' do
    fill_in 'service_name', with: 'new service'
    fill_in 'service_description', with: 'new description'
    click_button 'Create Service'

    expect(page).to have_content 'new service'
    expect(page).to have_content 'new description'
  end

  scenario 'admin add new service with invalid name' do
    fill_in 'service_name', with: ''
    click_button 'Create Service'

    expect(page).to have_content "Name can't be blank"
  end

  scenario 'admin add new service with exists name' do
    service = create :service

    fill_in 'service_name', with: service.name
    click_button 'Create Service'

    expect(page).to have_content 'Name has already been taken'
  end
end
