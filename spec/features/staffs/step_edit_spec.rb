feature 'Edit step' do
  include_context 'a logged in admin'

  before do
    create_list :step, 5
    @parent_step = create :step
    @next_step = create :step
    @prev_step = create :step
    @product = create :product
    # @form = create :form

    visit staff_steps_path
  end

  scenario 'admin edit the first step' do
    find_all('a', text: 'Edit').first.click

    fill_in 'step_name', with: 'updated name'
    fill_in 'step_description', with: 'updated description'
    find("#step_parent_id option[value='#{@parent_step.id}']").select_option
    find("#step_next_step_id option[value='#{@next_step.id}']").select_option
    find("#step_prev_step_id option[value='#{@prev_step.id}']").select_option
    find("#step_product_id option[value='#{@product.id}']").select_option
    # find("option[value='#{@form.id}']").select_option

    click_button 'Update Step'

    expect(page).to have_content 'updated name'
    expect(page).to have_content 'updated description'
    expect(page).to have_content @parent_step.name
    expect(page).to have_content @next_step.name
    expect(page).to have_content @prev_step.name
    expect(page).to have_content @product.name
    # expect(page).to have_content @form.name
  end

  scenario 'admin edit step with invalid name' do
    find_all('a', text: 'Edit').first.click

    fill_in 'step_name', with: ''
    click_button 'Update Step'

    expect(page).to have_content "Name can't be blank"
  end
end
