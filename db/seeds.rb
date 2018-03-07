# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
  Role.create(roles)

  p "CREATED ROLES - #{roles_name.join(',')}"
end

def create_staffs
  organization = Organization.first
  roles_name = Role.all

  roles_name.each do |role|
    staff = Staff.find_or_create_by!(email: "#{role.name}@example.com") do |s|
      s.mobile_phone = Faker::PhoneNumber.cell_phone
      s.password = 'password'
      s.password_confirmation = 'password'
      # s.organization = organization
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


create_organizations
create_roles
create_staffs

create_products
create_products_steps
