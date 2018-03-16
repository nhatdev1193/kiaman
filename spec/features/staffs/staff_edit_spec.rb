feature 'Edit staff' do
  include_context 'a logged in admin'

  before do
    role = create :role
    create_list :staff, 5, roles: [role]
    visit staff_staffs_path
  end

  scenario 'admin edit the last staff' do
    other_role = create :role

    find_all('a', text: 'Edit').last.click

    fill_in 'staff_name', with: 'updated name'
    fill_in 'staff_email', with: 'updated_email@example.com'
    fill_in 'staff_address', with: 'updated address'
    fill_in 'staff_phone', with: '381234567'
    fill_in 'staff_mobile_phone', with: '0123456789'
    select other_role.name, from: 'staff_role_ids', visible: false

    click_button 'Update Staff'

    expect(page).to have_content 'updated name'
    expect(page).to have_content 'updated_email@example.com'
    expect(page).to have_content other_role.name.humanize
  end

  context 'admin edit staff with invalid data' do
    scenario 'invalid email' do
      find_all('a', text: 'Edit').last.click

      fill_in 'staff_email', with: ''

      click_button 'Update Staff'

      expect(page).to have_content "Email can't be blank"
    end

    scenario 'invalid mobile phone' do
      find_all('a', text: 'Edit').last.click

      fill_in 'staff_mobile_phone', with: ''

      click_button 'Update Staff'

      expect(page).to have_content "Mobile phone can't be blank"
    end
  end
end
