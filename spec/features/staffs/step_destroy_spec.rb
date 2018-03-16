feature 'Destroy step' do
  include_context 'a logged in admin'

  before do
    @step = create :step
    visit staff_steps_path
  end

  scenario 'admin delete the step' do
    find_all('a', text: 'Delete').last.click
    expect(page).to have_content 'Restore'
  end
end
