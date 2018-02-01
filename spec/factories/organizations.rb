FactoryBot.define do
  factory :organization do
    name { Faker::Hipster.word }
    parent_id 0
    level 1
    deleted_at nil
  end
end
