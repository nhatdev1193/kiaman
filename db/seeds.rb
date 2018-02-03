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
  roles_name = %w[admin manager sale evaluator collector]
  roles = []
  roles_name.each_with_index do |name, idx|
    roles.push({ name: name, description: "#{name} role", level: idx + 1 })
  end
  Role.create(roles)

  p "CREATED ROLES - #{roles_name.join(',')}"
end

def create_admin
  organization = Organization.first
  admin_role = Role.find_by(name: 'admin')

  staff = Staff.find_or_create_by!(email: Rails.application.secrets.admin_email) do |u|
    u.mobile_phone = Faker::PhoneNumber.cell_phone
    u.password = Rails.application.secrets.admin_password
    u.password_confirmation = Rails.application.secrets.admin_password
    u.role = admin_role
    u.organization = organization
  end

  p 'CREATED ADMIN staff: ' << staff.email
end

def create_staffs
  organization = Organization.first
  roles_name = Role.all

  roles_name.each do |role|
    staff = Staff.find_or_create_by!(email: "#{role.name}@example.com") do |s|
      s.mobile_phone = Faker::PhoneNumber.cell_phone
      s.password = 'password'
      s.password_confirmation = 'password'
      s.organization = organization
    end

    staff.save!
    staff.roles << role

    p "CREATED Staff: #{staff.email}"
  end
end

create_organizations
create_roles
create_admin
create_staffs
