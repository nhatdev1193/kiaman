feature 'Show products list' do
  include_context 'a logged in admin'

  before do
    @products = create_list :product, 5
  end

  scenario 'admin see products list' do
    visit staff_products_path

    expect(page).to have_content @products.first.name
  end
end
