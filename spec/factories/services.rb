FactoryBot.define do
  factory :service do
    name { Faker::Hipster.word }
    description { Faker::Lorem.sentence }
    deleted_at nil
  end
end
