FactoryBot.define do
  factory :form do
    step nil
    contract_kind nil
    name { Faker::Hipster.word }
    is_template false
  end
end
