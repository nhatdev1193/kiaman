require_relative './form_fields'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

def create_organizations
  organization = Organization.create(name: 'Kim An HQ', parent_id: 0, level: 1)

  puts "CREATED ORGANIZATION - #{organization.name}"
end

def create_roles
  organization = Organization.first
  roles_name = %w[admin manager sale evaluator collector]
  roles = []
  roles_name.each_with_index do |name, idx|
    roles.push({ name: name, description: "#{name} role", level: idx + 1, organization: organization })
  end
  Role.create!(roles)

  p "CREATED ROLES - #{roles_name.join(',')}"
end

def create_staffs
  roles_name = Role.all

  roles_name.each do |role|
    staff = Staff.find_or_create_by!(email: "#{role.name}@example.com") do |s|
      s.mobile_phone = Faker::PhoneNumber.cell_phone
      s.password = 'password'
      s.password_confirmation = 'password'
      s.roles << role
    end

    staff.save!

    p "CREATED Staff: #{staff.email}"
  end
end

def create_products
  product_kinds = ['Student Loan', 'SME Loan']

  product_kinds.each do |product_kind|
    Product.find_or_create_by!(name: product_kind)
    p "CREATED Products: #{product_kinds.join('-')}"
  end
end

def create_products_steps
  product_kinds = ['Student Loan', 'SME Loan']

  product_kinds.each do |product_kind|
    product = Product.find_or_create_by!(name: product_kind)

    prospect_step = Step.find_or_create_by!(name: "Prospect #{product_kind}", description: "Prospect #{product_kind}", product: product)
    fullfill_step = Step.find_or_create_by!(name: "Fullfill #{product_kind}", description: "Fullfill #{product_kind}", product: product)
    lead_step = Step.find_or_create_by!(name: "Lead #{product_kind}", description: "Lead #{product_kind}", product: product)
    sleep_contract_step = Step.find_or_create_by!(name: "Sleep Contract #{product_kind}", description: "Sleep Contract #{product_kind}", product: product)
    evaluate_step = Step.find_or_create_by!(name: "Evaluate #{product_kind}", description: "Evaluate #{product_kind}", product: product)

    prospect_step.update_attributes(next_step: fullfill_step)
    fullfill_step.update_attributes(next_step: lead_step, prev_step: prospect_step)
    lead_step.update_attributes(next_step: sleep_contract_step, prev_step: fullfill_step)
    sleep_contract_step.update_attributes(next_step: evaluate_step, prev_step: lead_step)
    evaluate_step.update_attributes(prev_step: sleep_contract_step)

    p "CREATED Products Steps: #{product_kind}"
  end
end

def create_form_inputs
  types = %w[input text_area date select]
  types.each do |type|
    FormInput.find_or_create_by!(name: type, render_type: type)
  end
  p "CREATED Form Input: #{types.join(', ')}"
end

def create_forms
  Form.create!(name: 'KHÁCH HÀNG')
  p 'CREATED Form: KHÁCH HÀNG'
end

def single_condition(field)
  cdt = Condition.create(name: "#{field[:field_name]}_condition",
                         condition: { validator: field[:condition][0], operator: field[:condition][1], value: field[:condition][2] })
  ConditionGroup.create(condition: cdt)
end

def multi_condition(field)
  cdt_group = ConditionGroup.create(operator: field[:operator])
  field[:multi_condition].each_with_index do |condition, idx|
    cdt = Condition.create(name: "#{field[:field_name]}_condition_#{idx + 1}",
                           condition: { validator: condition[0], operator: condition[1], value: condition[2] })
    ConditionGroup.create(condition: cdt, parent_id: cdt_group.id)
  end
  cdt_group
end

def create_form_fields
  form = Form.first
  @fields.each do |field|
    cdt_group = single_condition(field) if field[:condition]
    cdt_group = multi_condition(field) if field[:multi_condition]

    FormField.create(field_name: field[:field_name],
                     display_name: field[:display_name],
                     form: form,
                     form_input: FormInput.find_by_name(field[:type]),
                     condition_group: cdt_group)
  end
end

DatabaseCleaner.clean
create_organizations
create_roles
create_staffs
create_form_inputs
create_forms
create_form_fields
create_products
create_products_steps
