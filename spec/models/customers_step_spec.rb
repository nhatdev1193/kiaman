require 'rails_helper'

RSpec.describe CustomersStep, type: :model do
  it { is_expected.to belong_to :step }
  it { is_expected.to belong_to :customer }
  it { is_expected.to belong_to :contract }

  customers_step = CustomersStep.new
  it { customers_step.should allow_event :next_step }
  it { customers_step.should allow_event :previous_step }
  it { customers_step.should allow_event :end_step }
end
