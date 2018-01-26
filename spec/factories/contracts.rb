FactoryBot.define do
  factory :contract do
    customer nil
    staff nil
    contract_kind nil
    current_workflow 'MyString'
    current_step 'MyString'
  end
end
