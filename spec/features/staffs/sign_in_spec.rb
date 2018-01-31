# Feature: Sign in
#   As a staff
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :devise do
  # Scenario: Staff cannot sign in if not registered
  #   Given I do not exist as a staff
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'staff cannot sign in if not registered' do
    signin('test@example.com', 'please123')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  # Scenario: Staff can sign in with valid credentials
  #   Given I exist as a staff
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  scenario 'staff can sign in with valid credentials' do
    staff = FactoryBot.create(:staff)
    signin(staff.email, staff.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  # Scenario: Staff cannot sign in with wrong email
  #   Given I exist as a staff
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'staff cannot sign in with wrong email' do
    staff = FactoryBot.create(:staff)
    signin('invalid@email.com', staff.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  # Scenario: Staff cannot sign in with wrong password
  #   Given I exist as a staff
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'staff cannot sign in with wrong password' do
    staff = FactoryBot.create(:staff)
    signin(staff.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'
  end
end
