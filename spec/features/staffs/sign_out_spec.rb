# Feature: Sign out
#   As a staff
#   I want to sign out
#   So I can protect my account from unauthorized access
feature 'Sign out', :devise do
  # Scenario: Staff signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  scenario 'staff signs out successfully' do
    staff = FactoryBot.create(:staff)
    signin(staff.email, staff.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    click_link 'Sign out'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
