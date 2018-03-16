feature 'Show steps list' do
  include_context 'a logged in admin'

  before do
    @steps = create_list :step, 5
  end

  scenario 'admin see steps list' do
    visit staff_steps_path

    expect(page).to have_content @steps.first.name
    expect(page).to have_content @steps.last.name
  end
end
