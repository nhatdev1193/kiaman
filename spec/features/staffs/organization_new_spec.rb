feature 'Add new organization' do
  include_context 'a logged in admin'

  before do
    visit staff_organizations_path

    click_link 'New organization'

    @organization = create :organization
  end

  scenario 'admin add new organization' do
    fill_in 'organization_name', with: 'new organization'
    find('select[name="organization[parent_id]"]').find(:xpath, 'option[1]').select_option
    click_button 'Create Organization'

    expect(page).to have_content 'new organization'
    expect(page).to have_content @organization.name
  end

  scenario 'admin add new organization with invalid name' do
    fill_in 'organization_name', with: ''
    click_button 'Create Organization'

    expect(page).to have_content "Name can't be blank"
  end
end
