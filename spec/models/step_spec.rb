require 'rails_helper'

RSpec.describe Step, type: :model do
  it { is_expected.to have_many :children }
  it { is_expected.to belong_to :parent }
  it { is_expected.to belong_to :product }
  it { is_expected.to belong_to :form }
  it { is_expected.to belong_to :next_step }
  it { is_expected.to belong_to :prev_step }
end
