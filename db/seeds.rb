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
    form = product_kind == 'Student Loan' ? @student_form : @sme_form

    prospect_step = Step.find_or_create_by!(name: "Prospect #{product_kind}", description: "Prospect #{product_kind}", product: product)
    fullfill_step = Step.find_or_create_by!(name: "Fullfill #{product_kind}", description: "Fullfill #{product_kind}", product: product, form: form)
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
  @student_form = Form.create!(name: 'Form Sinh viên')
  p 'CREATED Form: Sinh viên'
  @sme_form = Form.create!(name: 'Form Tiểu thương')
  p 'CREATED Form: Tiểu thương'
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

def create_study_fields
  study_form = Form.first
  @study_fields.each do |field|
    create_form_field(study_form, field)
  end
end

def create_business_fields
  business_form = Form.last
  @business_fields.each do |field|
    create_form_field(business_form, field)
  end
end

def create_form_field(form, field)
  cdt_group = single_condition(field) if field[:condition]
  cdt_group = multi_condition(field) if field[:multi_condition]

  FormField.create(field_name: field[:field_name],
                   display_name: field[:display_name],
                   form: form,
                   form_input: FormInput.find_by_name(field[:type]),
                   condition_group: cdt_group)
end

def create_form_fields
  # Common fields
  @forms = Form.all
  @forms.each do |form|
    @fields.each do |field|
      create_form_field(form, field)
    end
  end

  # Study fields
  create_study_fields
  # Business fields
  create_business_fields
end

def create_document_kinds
  doc_kind_field_names = ['cmnd', 'ho_khau', 'don_de_nghi_vay_von', 'the_sinh_vien', 'bang_cap', 'bang_diem', 'phieu_luong']
  doc_kind_display_names = ['CMND', 'Hộ khẩu', 'Đơn đề nghị vay vốn', 'Thẻ sinh viên', 'Bằng cấp', 'Bảng điểm', 'Phiếu lương']

  doc_kind_field_names.map.with_index do |doc_kind_field_name, idx|
    DocumentKind.find_or_create_by!(field_name: doc_kind_field_name,
                                    display_name: doc_kind_display_names[idx])
  end

  p "CREATED Document kinds: #{doc_kind_field_names.join(', ')}"
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
create_document_kinds
