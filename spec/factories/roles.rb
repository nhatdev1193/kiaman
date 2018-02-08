FactoryBot.define do
  factory :role do
    name { Faker::Hipster.unique.word }
    description { Faker::Lorem.sentence }
    level 1
  end
end
