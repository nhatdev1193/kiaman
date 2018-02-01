require 'rails_helper'

describe Admin::StaffsController, type: :controller do
  let(:admin_role) { create(:role, name: 'admin', level: 1) }
  let(:ho_organization) { create(:organization, name: 'Kim An HO') }
  let(:admin) { create(:staff, role: admin_role, organization: ho_organization) }

  before { sign_in admin }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    let(:staff) { create(:staff) }

    it 'returns a success response' do
      get :show, params: { id: staff.id }
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
      let(:staff_attributes) { attributes_for(:staff, role_id: role.id, organization_id: organization.id) }

      it 'creates a new staff' do
        expect { action }.to change(Staff, :count).by(1)
      end

      it 'redirects to the created staff' do
        action
        expect(response).to redirect_to(admin_staff_path(Staff.last))
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

    context 'with invalid role_id param' do
      let(:staff_attributes) { attributes_for(:staff, role_id: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end

    context 'with invalid organization_id param' do
      let(:staff_attributes) { attributes_for(:staff, organization_id: '') }

      it "returns a success response (i.e. to display the 'new' template)" do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'GET #edit' do
    let(:staff) { create(:staff) }

    it 'returns a success response' do
      get :edit, params: { id: staff.id }
      expect(response).to be_success
    end
  end

  describe 'PUT #update' do
    let!(:staff) { create(:staff) }
    let(:action) { put :update, params: { id: staff.id, staff: staff_attributes } }

    context 'with valid params' do
      let(:staff_attributes) { { name: 'updated name', address: 'updated address' } }

      it 'updates the requested staff' do
        action
        staff.reload
        expect(staff.name).to eq 'updated name'
        expect(staff.address).to eq 'updated address'
      end

      it 'redirects to the staff' do
        action
        expect(response).to redirect_to(admin_staff_path(staff))
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
    let!(:staff) { create(:staff) }
    let(:action) { delete :destroy, params: { id: staff.id } }

    it 'destroys the requested staff' do
      expect { action }.to change(Staff, :count).by(-1)
    end

    it 'redirects to the staff list' do
      action
      expect(response).to redirect_to admin_staffs_path
    end
  end

  describe 'RECOVER #destroy' do
    let!(:staff) { create(:staff, deleted_at: Time.now) }
    let(:action) { delete :destroy, params: { id: staff.id } }

    it 'recovers the requested staff' do
      expect(staff.deleted_at).not_to be_nil
      expect { action }.to change(Staff, :count).by(1)
    end

    it 'redirects to the staff list' do
      action
      expect(response).to redirect_to admin_staffs_path
    end
  end
end
