Rails.configuration.to_prepare do
  begin
    puts "Including Model::Cmor::Rbac::UserConcern in #{Cmor::Rbac.user_class_name}"
    Cmor::Rbac.user_class_name.constantize.class_eval do
      include Model::Cmor::Rbac::UserConcern
    end
  rescue NameError => e
    "Could not include Model::Cmor::Rbac::UserConcern into #{Cmor::Rbac.user_class_name}. Error: #{e.message}"
  end
end