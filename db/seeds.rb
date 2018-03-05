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
  types = %w[input text_area]
  types.each do |type|
    FormInput.find_or_create_by!(name: type, render_type: type)
  end
  p "CREATED Form Input: #{types.join(', ')}"
end

def create_forms
  Form.create!(name: 'Registration Form')
  p 'CREATED Form: Registration Form'
end

def create_conditions
  validators = %w[presence string only_integer min_length max_length]
  operators = %w[> <]
  values = %w[20 5]
  validators.each do |validator|
    operator = %w[min_length max_length].include?(validator) ? operators.pop : '='
    value = %w[min_length max_length].include?(validator) ? values.pop : true
    Condition.create(name: validator,
                     condition: { validator: validator, operator: operator, value: value })
  end
  p 'CREATED Conditions'
end

def create_condition_groups
  # Group 1: presence && (min_length < 5 || max_length > 20)
  condition_group = %w[presence min_length max_length]
  @root_condition1 = ConditionGroup.create!(operator: 'AND')
  cg_or = ConditionGroup.create!(operator: 'OR', parent_id: @root_condition1.id)
  condition_group.each do |condition|
    parent = condition == 'presence' ? @root_condition1 : cg_or
    ConditionGroup.create!(condition: Condition.find_by_name(condition), parent_id: parent.id)
  end

  # Group 2: presence && string && max_length > 20
  @root_condition2 = ConditionGroup.create!(operator: 'AND')
  condition_group.each do |condition|
    ConditionGroup.create!(condition: Condition.find_by_name(condition), parent_id: @root_condition2.id)
  end

  # Group 3: only_integer
  @root_condition3 = ConditionGroup.create!(condition: Condition.find_by_name('only_integer'))

  p 'CREATED Condition Group'
end


def create_form_fields
  form = Form.first
  fields = {
    name: ['input', @root_condition1],
    address: ['text_area', @root_condition2],
    age: ['input', @root_condition3]
  }

  fields.each do |attr_name, attr_value|
    FormField.create(form: form,
                     form_input: FormInput.find_by_name(attr_value[0]),
                     condition_group: attr_value[1],
                     field_name: attr_name)
  end

  p 'CREATED Form Field'
end


DatabaseCleaner.clean
create_organizations
create_roles
create_staffs
create_services
create_form_inputs
create_forms
create_conditions
create_condition_groups
create_form_fields
