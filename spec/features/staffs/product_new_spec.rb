feature 'Add new product' do
  include_context 'a logged in admin'

  before do
    visit staff_products_path

    click_link 'New product'
  end

  scenario 'admin add new product' do
    fill_in 'product_name', with: 'new product'
    fill_in 'product_description', with: 'new description'
    click_button 'Create Product'

    expect(page).to have_content 'new product'
    expect(page).to have_content 'new description'
  end

  scenario 'admin add new product with invalid name' do
    fill_in 'product_name', with: ''
    click_button 'Create Product'

    expect(page).to have_content "Name can't be blank"
  end

  scenario 'admin add new product with exists name' do
    product = create :product

    fill_in 'product_name', with: product.name
    click_button 'Create Product'

    expect(page).to have_content 'Name has already been taken'
  end
end
