require 'rails_helper'

describe Staff::StepsController, type: :controller do
  let(:admin_role) { create(:role, name: 'admin', level: 1) }
  let(:oh_organization) { create(:organization, name: 'Kim An HO') }
  let(:admin) { create(:staff, roles: [admin_role], organization: oh_organization) }
  let(:service) { create(:service) }

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
      let(:step_attributes) { attributes_for(:step, service_id: service.id) }

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

    context 'with invalid service param' do
      let(:step_attributes) { attributes_for(:step, service_id: nil) }

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
      let(:step_attributes) { { name: 'updated name', service_id: service.id } }

      it 'updates the requested step' do
        action
        step.reload
        expect(step.name).to eq 'updated name'
        expect(step.service_id).to eq service.id
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

    context 'with invalid service param' do
      let(:step_attributes) { { service_id: nil } }

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
