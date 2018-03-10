require 'rails_helper'

describe Staff::StepsController, type: :controller do
  let(:ho_organization) { create(:organization, name: 'Kim An HO') }
  let(:admin_role) { create(:role, name: 'admin', level: 1, organization: ho_organization) }
  let(:admin) { create(:staff, roles: [admin_role]) }
  let(:product) { create(:product) }

  before { sign_in admin }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    let(:action) { post :create, params: { step: step_attributes } }

    context 'with valid params' do
      let(:step_attributes) { attributes_for(:step, product_id: product.id) }

      it 'creates a new step' do
        expect { action }.to change(Step, :count).by(1)
      end

      it 'redirects to the steps list' do
        action
        expect(response).to redirect_to(staff_steps_path)
      end
    end

    context 'with invalid name param' do
      let(:step_attributes) { attributes_for(:step, name: '') }

      it "returns a success response (i.e to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid product param' do
      let(:step_attributes) { attributes_for(:step, product_id: nil) }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid parent step, next step and prev step' do
      let(:step) { create(:step) }
      let(:step_attributes) { attributes_for(:step, parent_id: step.id, next_step_id: step.id, prev_step_id: step.id) }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    let(:step) { create(:step) }
    let(:action) { put :update, params: { id: step.id, step: step_attributes } }

    context 'with valid params' do
      let(:step_attributes) { { name: 'updated name', product_id: product.id } }

      it 'updates the requested step' do
        action
        step.reload
        expect(step.name).to eq 'updated name'
        expect(step.product_id).to eq product.id
      end

      it 'redirects to the steps list' do
        action
        expect(response).to redirect_to staff_steps_path
      end
    end

    context 'with invalid name param' do
      let(:step_attributes) { { name: '' } }

      it "returns a success response (i.e. to display the 'edit' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid product param' do
      let(:step_attributes) { { product_id: nil } }

      it "returns a success response (i.e. to display the 'edit' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:step) { create(:step) }
    let(:action) { delete :destroy, params: { id: step.id } }

    it 'destroys the requested step' do
      expect { action }.to change(Step, :count).by(-1)
    end

    it 'redirects to the steps list' do
      action
      expect(response).to redirect_to(staff_steps_path)
    end
  end

  describe 'RECOVER #destroy' do
    let!(:step) { create(:step, deleted_at: Time.now) }
    let(:action) { delete :destroy, params: { id: step.id } }

    it 'recovers the requested step' do
      expect(step.deleted_at).not_to be_nil
      expect { action }.to change(Step, :count).by(1)
    end

    it 'redirects to the steps list' do
      action
      expect(response).to redirect_to(staff_steps_path)
    end
  end
end
