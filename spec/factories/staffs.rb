FactoryBot.define do
  factory :staff do
    name 'Test Staff'
    email 'test@example.com'
    password 'please123'
    mobile_phone Faker::PhoneNumber.cell_phone
    role nil
    organization nil
  end
end
