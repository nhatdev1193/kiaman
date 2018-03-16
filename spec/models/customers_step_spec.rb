require 'rails_helper'

RSpec.describe PeopleStep, type: :model do
  it { is_expected.to belong_to :step }
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :contract }

  people_step = PeopleStep.new
  it { people_step.should allow_event :next_step }
  it { people_step.should allow_event :previous_step }
  it { people_step.should allow_event :end_step }
end
