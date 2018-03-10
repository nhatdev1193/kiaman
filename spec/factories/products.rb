FactoryBot.define do
  factory :product do
    name { Faker::Hipster.unique.word }
    description { Faker::Lorem.sentence }
    deleted_at nil
  end
end
