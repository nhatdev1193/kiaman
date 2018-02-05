require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to have_many :steps }
end
