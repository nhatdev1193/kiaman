feature 'Edit product' do
  include_context 'a logged in admin'

  before do
    create_list :product, 5
    visit staff_products_path
  end

  scenario 'admin edit the first product' do
    find_all('a', text: 'Edit').first.click

    fill_in 'product_name', with: 'updated name'
    fill_in 'product_description', with: 'updated description'
    click_button 'Update Product'

    expect(page).to have_content 'updated name'
    expect(page).to have_content 'updated description'
  end

  scenario 'admin edit product with invalid name' do
    find_all('a', text: 'Edit').first.click

    fill_in 'product_name', with: ''
    click_button 'Update Product'

    expect(page).to have_content "Name can't be blank"
  end
end
