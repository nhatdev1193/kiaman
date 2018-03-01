FactoryBot.define do
  factory :step do
    name { Faker::Hipster.unique.word }
    description { Faker::Lorem.sentence }
    parent_id nil
    product { create(:product) }
    prev_step_id nil
    next_step_id nil
    form_id nil
  end
end
