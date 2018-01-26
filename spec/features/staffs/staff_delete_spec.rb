include Warden::Test::Helpers
Warden.test_mode!

# Feature: Staff delete
#   As a staff
#   I want to delete my staff profile
#   So I can close my account
feature 'Staff delete', :devise, :js do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Staff can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'staff can delete own account' do
    skip 'skip a slow test'
    staff = FactoryBot.create(:staff)
    login_as(staff, scope: :staff)
    visit edit_staff_registration_path(staff)
    click_button 'Cancel my account'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end




