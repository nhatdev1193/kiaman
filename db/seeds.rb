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

def create_services
  service_kinds = ['Student Loan', 'SME Loan']

  service_kinds.each do |service_kind|
    Service.find_or_create_by!(name: service_kind)
    p "CREATED Services: #{service_kinds.join('-')}"
  end
end

def create_services_steps
  service_kinds = ['Student Loan', 'SME Loan']

  service_kinds.each do |service_kind|
    Service.find_or_create_by!(name: service_kind)
    p "CREATED Services: #{service_kinds}"
  end
end

def create_form_inputs
  types = %w[string text_area]
  types.each do |type|
    FormInput.find_or_create_by!(name: type, render_type: type)
  end
  p "CREATED Form Input: #{types}"
end


DatabaseCleaner.clean
create_organizations
create_roles
create_staffs
create_services
create_form_inputs
