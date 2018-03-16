require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { is_expected.to have_many :staffs }
  it { is_expected.to have_many :children }
  it { is_expected.to belong_to :parent }
end
