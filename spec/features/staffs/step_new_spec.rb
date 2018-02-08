feature 'Add new step' do
  include_context 'a logged in admin'

  before do
    @parent_step = create :step
    @next_step = create :step
    @prev_step = create :step
    @service = create :service

    visit staff_steps_path

    click_link 'New step'
  end

  scenario 'admin add new step' do
    fill_in 'step_name', with: 'new name'
    fill_in 'step_description', with: 'new description'
    find("#step_parent_id option[value='#{@parent_step.id}']").select_option
    find("#step_next_step_id option[value='#{@next_step.id}']").select_option
    find("#step_prev_step_id option[value='#{@prev_step.id}']").select_option
    find("#step_service_id option[value='#{@service.id}']").select_option

    click_button 'Create Step'

    expect(page).to have_content 'new name'
    expect(page).to have_content 'new description'
    expect(page).to have_content @parent_step.name
    expect(page).to have_content @next_step.name
    expect(page).to have_content @prev_step.name
    expect(page).to have_content @service.name
  end

  context 'admin add new step with invalid data' do
    scenario 'invalid name' do
      fill_in 'step_name', with: ''
      fill_in 'step_description', with: 'new description'
      find("#step_parent_id option[value='#{@parent_step.id}']").select_option
      find("#step_next_step_id option[value='#{@next_step.id}']").select_option
      find("#step_prev_step_id option[value='#{@prev_step.id}']").select_option
      find("#step_service_id option[value='#{@service.id}']").select_option

      click_button 'Create Step'

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'invalid service' do
      fill_in 'step_name', with: 'new name'
      fill_in 'step_description', with: 'new description'
      find("#step_parent_id option[value='#{@parent_step.id}']").select_option
      find("#step_next_step_id option[value='#{@next_step.id}']").select_option
      find("#step_prev_step_id option[value='#{@prev_step.id}']").select_option

      click_button 'Create Step'

      expect(page).to have_content "Service can't be blank"
    end
  end
end
