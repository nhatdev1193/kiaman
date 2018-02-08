feature 'Edit organization' do
  include_context 'a logged in admin'

  before do
    create_list :organization, 5
    visit staff_organizations_path
  end

  scenario 'admin edit the first organization' do
    find_all('a', text: 'Edit').first.click

    fill_in 'organization_name', with: 'updated organization'
    click_button 'Update Organization'

    expect(page).to have_content 'updated organization'
  end

  scenario 'admin edit organization with invalid name' do
    find_all('a', text: 'Edit').first.click

    fill_in 'organization_name', with: ''
    click_button 'Update Organization'

    expect(page).to have_content "Name can't be blank"
  end
end
