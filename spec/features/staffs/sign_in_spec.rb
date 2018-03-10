feature 'Sign in', :devise do
  before :all do
    ho_organization = Organization.find_or_create_by name: 'Kim An HO'
    @role = Role.find_or_create_by name: 'admin', organization: ho_organization
  end

  before :each do
    visit new_staff_session_path
  end

  scenario 'staff cannot sign in if not registered' do
    signin 'invalid_mail@example.com', 'password'

    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  scenario 'staff can sign in with valid credentials' do
    staff = create :staff, roles: [@role]

    signin staff.email, staff.password

    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'staff cannot sign in with wrong email' do
    staff = create :staff, roles: [@role]
    signin 'invalid@email.com', staff.password
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  scenario 'staff cannot sign in with wrong password' do
    staff = create :staff, roles: [@role]
    signin(staff.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'
  end
end
