feature 'Add new staff' do
  include_context 'a logged in admin'

  before do
    @other_role = create :role
    @organization = create :organization

    visit staff_staffs_path

    click_link 'New staff'
  end

  scenario 'admin add new staff' do
    fill_in 'staff_name', with: 'new name'
    fill_in 'staff_email', with: 'new_email@example.com'
    fill_in 'staff_password', with: 'password'
    fill_in 'staff_password_confirmation', with: 'password'
    fill_in 'staff_address', with: 'new address'
    fill_in 'staff_phone', with: '381234567'
    fill_in 'staff_mobile_phone', with: '0123456789'
    find(:css, "#staff_role_ids_#{@other_role.id}").set(true)
    find("option[value='#{@organization.id}']").select_option

    click_button 'Create Staff'

    expect(page).to have_content 'new name'
    expect(page).to have_content 'new_email@example.com'
    expect(page).to have_content @other_role.name.humanize
  end

  context 'admin add new staff with invalid data' do
    scenario 'invalid email' do
      fill_in 'staff_name', with: 'new name'
      fill_in 'staff_email', with: ''
      fill_in 'staff_password', with: 'password'
      fill_in 'staff_password_confirmation', with: 'password'
      fill_in 'staff_address', with: 'new address'
      fill_in 'staff_phone', with: '381234567'
      fill_in 'staff_mobile_phone', with: '0123456789'
      find(:css, "#staff_role_ids_#{@other_role.id}").set(true)
      find("option[value='#{@organization.id}']").select_option

      click_button 'Create Staff'

      expect(page).to have_content "Email can't be blank"
    end

    scenario 'invalid password confirmation' do
      fill_in 'staff_name', with: 'new name'
      fill_in 'staff_email', with: 'new_email@example.com'
      fill_in 'staff_password', with: 'password'
      fill_in 'staff_password_confirmation', with: 'password2'
      fill_in 'staff_address', with: 'new address'
      fill_in 'staff_phone', with: '381234567'
      fill_in 'staff_mobile_phone', with: '0123456789'
      find(:css, "#staff_role_ids_#{@other_role.id}").set(true)
      find("option[value='#{@organization.id}']").select_option

      click_button 'Create Staff'

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'invalid password' do
      fill_in 'staff_name', with: 'new name'
      fill_in 'staff_email', with: 'new_email@example.com'
      fill_in 'staff_address', with: 'new address'
      fill_in 'staff_phone', with: '381234567'
      fill_in 'staff_mobile_phone', with: '0123456789'
      find(:css, "#staff_role_ids_#{@other_role.id}").set(true)
      find("option[value='#{@organization.id}']").select_option

      click_button 'Create Staff'

      expect(page).to have_content "Password can't be blank"
    end

    scenario 'invalid organization' do
      fill_in 'staff_name', with: 'new name'
      fill_in 'staff_email', with: 'new_email@example.com'
      fill_in 'staff_password', with: 'password'
      fill_in 'staff_password_confirmation', with: 'password'
      fill_in 'staff_address', with: 'new address'
      fill_in 'staff_phone', with: '381234567'
      fill_in 'staff_mobile_phone', with: '0123456789'
      find(:css, "#staff_role_ids_#{@other_role.id}").set(true)

      click_button 'Create Staff'

      expect(page).to have_content "Organization can't be blank"
    end

    scenario 'invalid mobile phone' do
      fill_in 'staff_name', with: 'new name'
      fill_in 'staff_email', with: 'new_email@example.com'
      fill_in 'staff_password', with: 'password'
      fill_in 'staff_password_confirmation', with: 'password'
      fill_in 'staff_address', with: 'new address'
      fill_in 'staff_phone', with: '381234567'
      fill_in 'staff_mobile_phone', with: ''
      find(:css, "#staff_role_ids_#{@other_role.id}").set(true)
      find("option[value='#{@organization.id}']").select_option

      click_button 'Create Staff'

      expect(page).to have_content "Mobile phone can't be blank"
    end

    scenario 'invalid role' do
      fill_in 'staff_name', with: 'new name'
      fill_in 'staff_email', with: 'new_email@example.com'
      fill_in 'staff_password', with: 'password'
      fill_in 'staff_password_confirmation', with: 'password'
      fill_in 'staff_address', with: 'new address'
      fill_in 'staff_phone', with: '381234567'
      fill_in 'staff_mobile_phone', with: '0123456789'
      find("option[value='#{@organization.id}']").select_option

      click_button 'Create Staff'

      expect(page).to have_content "Roles can't be blank"
    end
  end
end
