feature 'Destroy organization' do
  include_context 'a logged in admin'

  before do
    @organization = create :organization
    visit staff_organizations_path
  end

  scenario 'admin delete the organization' do
    find_all('a', text: 'Delete').last.click
    expect(page).to_not have_content @organization.name
  end
end
