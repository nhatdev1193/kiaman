feature 'Show organization list' do
  include_context 'a logged in admin'

  before do
    @organizations = create_list :organization, 5
  end

  scenario 'admin see organizations list' do
    visit staff_organizations_path

    expect(page).to have_content @organizations.first.name
  end
end
