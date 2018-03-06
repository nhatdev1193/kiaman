require 'rails_helper'

describe Staff::ProductsController, type: :controller do
  let(:ho_organization) { create(:organization, name: 'Kim An HO') }
  let(:admin_role) { create(:role, name: 'admin', level: 1, organization: ho_organization) }
  let(:admin) { create(:staff, roles: [admin_role]) }

  before { sign_in admin }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    let(:action) { post :create, params: { product: product_attributes } }

    context 'with valid params' do
      let(:role) { create(:role) }
      let(:organization) { create(:organization) }
      let(:product_attributes) { attributes_for(:product) }

      it 'creates a new product' do
        expect { action }.to change(Product, :count).by(1)
      end

      it 'redirects to the products list' do
        action
        expect(response).to redirect_to(staff_products_path)
      end
    end

    context 'with invalid name param' do
      let(:product_attributes) { attributes_for(:product, name: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid name exists' do
      let(:another_product) { create(:product) }
      let(:product_attributes) { attributes_for(:product, name: another_product.name) }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    let(:product) { create(:product) }

    it 'returns a success response' do
      get :edit, params: { id: product.id }
      expect(response).to be_success
    end
  end

  describe 'PUT #update' do
    let!(:product) { create(:product) }
    let(:action) { put :update, params: { id: product.id, product: product_attributes } }

    context 'with valid params' do
      let(:product_attributes) { { name: 'updated name' } }

      it 'updates the requested product' do
        action
        product.reload
        expect(product.name).to eq 'updated name'
      end

      it 'redirects to the products list' do
        action
        expect(response).to redirect_to(staff_products_path)
      end
    end

    context 'with invalid params' do
      let(:product_attributes) { { name: '' } }

      it "returns a success response (i.e to display the 'edit' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:product) { create(:product) }
    let(:action) { delete :destroy, params: { id: product.id } }

    it 'destroys the requested product' do
      expect { action }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      action
      expect(response).to redirect_to staff_products_path
    end
  end

  describe 'RECOVER #destroy' do
    let!(:product) { create(:product, deleted_at: Time.now) }
    let(:action) { delete :destroy, params: { id: product.id } }

    it 'recovers the requested product' do
      expect(product.deleted_at).not_to be_nil
      expect { action }.to change(Product, :count).by(1)
    end

    it 'redirects to the product list' do
      action
      expect(response).to redirect_to staff_products_path
    end
  end
end
