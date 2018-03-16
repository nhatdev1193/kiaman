feature 'Sign out', :devise do
  scenario 'staff signs out successfully' do
    ho_organization = Organization.find_or_create_by name: 'Kim An HO'
    role = Role.find_or_create_by name: 'admin', organization: ho_organization
    staff = create :staff, roles: [role]

    signin(staff.email, staff.password)

    expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    click_link 'Logout'

    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
