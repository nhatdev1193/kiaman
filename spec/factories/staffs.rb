FactoryBot.define do
  factory :staff do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'please123'
    mobile_phone Faker::PhoneNumber.cell_phone
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.phone_number }
    deleted_at nil
  end
end
