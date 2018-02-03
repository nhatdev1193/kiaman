require 'rails_helper'

describe Staff::OrganizationsController, type: :controller do
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
    let(:action) { post :create, params: { organization: organization_attributes } }

    context 'with valid params' do
      let(:organization_attributes) { attributes_for(:organization) }

      it 'creates a new organization' do
        expect { action }.to change(Organization, :count).by(1)
      end

      it 'redirects to the created organization' do
        action
        expect(response).to redirect_to(staff_organizations_path)
      end
    end

    context 'with invalid name param' do
      let(:organization_attributes) { attributes_for(:organization, name: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid level param' do
      let(:organization_attributes) { attributes_for(:organization, level: nil) }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    let(:organization) { create(:organization) }

    it 'returns a success response' do
      get :edit, params: { id: organization.id }
      expect(response).to be_success
    end
  end

  describe 'PUT #update' do
    let!(:organization) { create(:organization) }
    let(:action) { put :update, params: { id: organization.id, organization: organization_attributes } }

    context 'with valid params' do
      let(:organization_attributes) { { name: 'updated name', level: 5 } }

      it 'updates the requested organization' do
        action
        organization.reload
        expect(organization.name).to eq 'updated name'
        expect(organization.level).to eq 5
      end

      it 'redirects to the organization' do
        action
        expect(response).to redirect_to(staff_organizations_path)
      end
    end

    context 'with invalid params' do
      let(:organization_attributes) { { name: '' } }

      it "returns a success response (i.e. to display the 'edit' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:organization) { create(:organization) }
    let(:action) { delete :destroy, params: { id: organization.id } }

    it 'destroys the requested organization' do
      expect { action }.to change(Organization, :count).by(-1)
    end

    it 'redirects to the organization list' do
      action
      expect(response).to redirect_to(staff_organizations_path)
    end
  end

  describe 'RECOVER #destroy' do
    let!(:organization) { create(:organization, deleted_at: Time.now) }
    let(:action) { delete :destroy, params: { id: organization.id } }

    it 'recovers the requested organization' do
      expect(organization.deleted_at).not_to be_nil
      expect { action }.to change(Organization, :count).by(1)
    end

    it 'redirects to the organization list' do
      action
      expect(response).to redirect_to(staff_organizations_path)
    end
  end
end
