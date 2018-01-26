include Warden::Test::Helpers
Warden.test_mode!

# Feature: Staff profile page
#   As a staff
#   I want to visit my staff profile page
#   So I can see my personal account data
feature 'Staff profile page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Staff sees own profile
  #   Given I am signed in
  #   When I visit the staff profile page
  #   Then I see my own email address
  scenario 'staff sees own profile' do
    staff = FactoryBot.create(:staff)
    login_as(staff, scope: :staff)
    visit staff_path(staff)
    expect(page).to have_content 'Staff'
    expect(page).to have_content staff.email
  end

  # Scenario: Staff cannot see another staff's profile
  #   Given I am signed in
  #   When I visit another staff's profile
  #   Then I see an 'access denied' message
  scenario "staff cannot see another staff's profile" do
    me = FactoryBot.create(:staff)
    other = FactoryBot.create(:staff, email: 'other@example.com')
    login_as(me, scope: :staff)
    Capybara.current_session.driver.header 'Referer', root_path
    visit staff_path(other)
    expect(page).to have_content 'Access denied.'
  end
end
