require 'rails_helper'

describe Staff::ServicesController, type: :controller do
  let(:admin_role) { create(:role, name: 'admin', level: 1) }
  let(:ho_organization) { create(:organization, name: 'Kim An HO') }
  let(:admin) { create(:staff, roles: [admin_role], organization: ho_organization) }

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
    let(:action) { post :create, params: { service: service_attributes } }

    context 'with valid params' do
      let(:role) { create(:role) }
      let(:organization) { create(:organization) }
      let(:service_attributes) { attributes_for(:service) }

      it 'creates a new service' do
        expect { action }.to change(Service, :count).by(1)
      end

      it 'redirects to the created service' do
        action
        expect(response).to redirect_to(staff_services_path)
      end
    end

    context 'with invalid name param' do
      let(:service_attributes) { attributes_for(:service, name: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid name exists' do
      let(:another_service) { create(:service) }
      let(:service_attributes) { attributes_for(:service, name: another_service.name) }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    let(:service) { create(:service) }

    it 'returns a success response' do
      get :edit, params: { id: service.id }
      expect(response).to be_success
    end
  end

  describe 'PUT #update' do
    let!(:service) { create(:service) }
    let(:action) { put :update, params: { id: service.id, service: service_attributes } }

    context 'with valid params' do
      let(:service_attributes) { { name: 'updated name' } }

      it 'updates the requested service' do
        action
        service.reload
        expect(service.name).to eq 'updated name'
      end

      it 'redirects to the service' do
        action
        expect(response).to redirect_to(staff_services_path)
      end
    end

    context 'with invalid params' do
      let(:service_attributes) { { name: '' } }

      it "returns a success response (i.e to display the 'edit' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:service) { create(:service) }
    let(:action) { delete :destroy, params: { id: service.id } }

    it 'destroys the requested service' do
      expect { action }.to change(Service, :count).by(-1)
    end

    it 'redirects to the service list' do
      action
      expect(response).to redirect_to staff_services_path
    end
  end

  describe 'RECOVER #destroy' do
    let!(:service) { create(:service, deleted_at: Time.now) }
    let(:action) { delete :destroy, params: { id: service.id } }

    it 'recovers the requested service' do
      expect(service.deleted_at).not_to be_nil
      expect { action }.to change(Service, :count).by(1)
    end

    it 'redirects to the service list' do
      action
      expect(response).to redirect_to staff_services_path
    end
  end
end
