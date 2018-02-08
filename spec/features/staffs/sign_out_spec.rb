feature 'Sign out', :devise do
  scenario 'staff signs out successfully' do
    role = Role.find_or_create_by name: 'admin'
    staff = create :staff, roles: [role]

    signin(staff.email, staff.password)

    expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    click_link 'Logout'

    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
