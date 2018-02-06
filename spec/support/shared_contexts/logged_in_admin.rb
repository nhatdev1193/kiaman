shared_context 'a logged in admin' do
  before 'create and login as admin' do
    role = Role.find_or_create_by name: 'admin'
    @admin ||= create :staff, roles: [role]

    visit new_staff_session_path

    signin @admin.email, @admin.password

    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end
end
