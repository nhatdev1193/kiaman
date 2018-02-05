require 'rails_helper'

RSpec.describe Form, type: :model do
  it { is_expected.to have_many :steps }
end
