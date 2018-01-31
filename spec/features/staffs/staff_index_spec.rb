include Warden::Test::Helpers
Warden.test_mode!

# Feature: Staff index page
#   As a staff
#   I want to see a list of staffs
#   So I can see who has registered
feature 'Staff index page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Staff listed on index page
  #   Given I am signed in
  #   When I visit the staff index page
  #   Then I see my own email address
  scenario 'staff sees own email address' do
    staff = FactoryBot.create(:staff)
    login_as(staff, scope: :staff)
    visit staffs_path
    expect(page).to have_content staff.email
  end
end
