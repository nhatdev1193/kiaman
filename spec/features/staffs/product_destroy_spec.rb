feature 'Destroy product' do
  include_context 'a logged in admin'

  before do
    @product = create :product

    visit staff_products_path
  end

  scenario 'admin delete the product' do
    find_all('a', text: 'Delete').last.click

    expect(page).to have_content 'Restore'
  end
end
