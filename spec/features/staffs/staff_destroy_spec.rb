feature 'Destroy staff' do
  include_context 'a logged in admin'

  before do
    role = create :role
    @staff = create :staff, roles: [role]
    visit staff_staffs_path
  end

  scenario 'admin delete the staff' do
    find_all('a', text: 'Delete').last.click
    expect(page).to have_content 'Restore'
  end
end
