feature 'Show staffs list' do
  include_context 'a logged in admin'

  before do
    role = create :role
    @staffs = create_list :staff, 5, roles: [role]
  end

  scenario 'admin see staffs list' do
    visit staff_staffs_path

    expect(page).to have_content @staffs.first.name
    expect(page).to have_content @staffs.first.email
  end
end
