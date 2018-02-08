feature 'Edit service' do
  include_context 'a logged in admin'

  before do
    create_list :service, 5
    visit staff_services_path
  end

  scenario 'admin edit the first service' do
    find_all('a', text: 'Edit').first.click

    fill_in 'service_name', with: 'updated name'
    fill_in 'service_description', with: 'updated description'
    click_button 'Update Service'

    expect(page).to have_content 'updated name'
    expect(page).to have_content 'updated description'
  end

  scenario 'admin edit service with invalid name' do
    find_all('a', text: 'Edit').first.click

    fill_in 'service_name', with: ''
    click_button 'Update Service'

    expect(page).to have_content "Name can't be blank"
  end
end
