require 'rails_helper'

RSpec.describe RolePermission, type: :model do
  it { is_expected.to belong_to :role }
  it { is_expected.to belong_to :permission }
  it { is_expected.to belong_to :organization }
end
