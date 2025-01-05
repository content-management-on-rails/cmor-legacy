Rails.configuration.to_prepare do
  ActiveSupport.on_load(:active_record) do
    begin
      print "[CMOR RBAC] Including Model::Cmor::Rbac::UserConcern in #{Cmor::Rbac.user_class_name}"
      Cmor::Rbac.user_class_name.constantize.class_eval do
        include Model::Cmor::Rbac::UserConcern
        puts " => [OK]"
      end
    rescue NameError => e
      puts " => [FAILED]"
      puts "  Could not include Model::Cmor::Rbac::UserConcern into #{Cmor::Rbac.user_class_name}. Error: #{e.message}"
    end
  end
end
