include Warden::Test::Helpers
Warden.test_mode!

# Feature: Staff edit
#   As a staff
#   I want to edit my staff profile
#   So I can change my email address
feature 'Staff edit', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Staff changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'staff changes email address' do
    staff = FactoryBot.create(:staff)
    login_as(staff, scope: :staff)
    visit edit_staff_registration_path(staff)
    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Current password', with: staff.password
    click_button 'Update'
    txts = [I18n.t('devise.registrations.updated'), I18n.t('devise.registrations.update_needs_confirmation')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: Staff cannot edit another staff's profile
  #   Given I am signed in
  #   When I try to edit another staff's profile
  #   Then I see my own 'edit profile' page
  scenario "staff cannot cannot edit another staff's profile", :me do
    me = FactoryBot.create(:staff)
    other = FactoryBot.create(:staff, email: 'other@example.com')
    login_as(me, scope: :staff)
    visit edit_staff_registration_path(other)
    expect(page).to have_content 'Edit Staff'
    expect(page).to have_field('Email', with: me.email)
  end
end
