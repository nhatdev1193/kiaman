namespace :db do
  desc 'Loading all models and their related controller methods in permissions table.'
  task seed_permissions: :environment do
    arr = []

    # Load all the controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        # Check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ # namescoped controllers
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/
            arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end

    arr.each do |controller|
      controller.action_methods.each do |action_name|
        # Check if the permission is present
        permission = Permission.find_by(controller_path: controller.controller_path, action_name: action_name)
        next if permission

        # Else add a new one.
        created_permission = Permission.create!(controller_path: controller.controller_path,
                                                action_name:     action_name,
                                                name:            "#{controller.controller_path} | #{action_name}")
        p 'Permission added: ' << created_permission.controller_path << ' | ' << created_permission.action_name
      end
    end
  end
end