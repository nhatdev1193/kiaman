FactoryGirl.define do
  factory :step do
    prev_step_id 1
    contract_kind nil
    name 'MyString'
    description 'MyText'
  end
end
