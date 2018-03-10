require 'rails_helper'

describe Staff::StaffsController, type: :controller do
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
    let(:action) { post :create, params: { staff: staff_attributes } }

    context 'with valid params' do
      let(:role) { create(:role) }
      let(:organization) { create(:organization) }
      let(:staff_attributes) { attributes_for(:staff, role_ids: [role.id], organization_id: organization.id) }

      it 'creates a new staff' do
        expect { action }.to change(Staff, :count).by(1)
      end

      it 'redirects to the staffs list' do
        action
        expect(response).to redirect_to(staff_staffs_path)
      end
    end

    context 'with invalid email param' do
      let(:staff_attributes) { attributes_for(:staff, email: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid mobile_phone param' do
      let(:staff_attributes) { attributes_for(:staff, mobile_phone: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    let(:staff) { create(:staff, roles: [admin_role]) }

    it 'returns a success response' do
      get :edit, params: { id: staff.id }
      expect(response).to be_success
    end
  end

  describe 'PUT #update' do
    let!(:staff) { create(:staff, roles: [admin_role]) }
    let(:action) { put :update, params: { id: staff.id, staff: staff_attributes } }

    context 'with valid params' do
      let(:staff_attributes) { { name: 'updated name', address: 'updated address' } }

      it 'updates the requested staff' do
        action
        staff.reload
        expect(staff.name).to eq 'updated name'
        expect(staff.address).to eq 'updated address'
      end

      it 'redirects to the staffs list' do
        action
        expect(response).to redirect_to(staff_staffs_path)
      end
    end

    context 'with invalid params' do
      let(:staff_attributes) { { mobile_phone: '' } }

      it "returns a success response (i.e to display the 'edit' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:staff) { create(:staff, roles: [admin_role]) }
    let(:action) { delete :destroy, params: { id: staff.id } }

    it 'destroys the requested staff' do
      expect { action }.to change(Staff, :count).by(-1)
    end

    it 'redirects to the staff list' do
      action
      expect(response).to redirect_to staff_staffs_path
    end
  end

  describe 'RECOVER #destroy' do
    let!(:staff) { create(:staff, roles: [admin_role], deleted_at: Time.now) }
    let(:action) { delete :destroy, params: { id: staff.id } }

    it 'recovers the requested staff' do
      expect(staff.deleted_at).not_to be_nil
      expect { action }.to change(Staff, :count).by(1)
    end

    it 'redirects to the staff list' do
      action
      expect(response).to redirect_to staff_staffs_path
    end
  end
end
