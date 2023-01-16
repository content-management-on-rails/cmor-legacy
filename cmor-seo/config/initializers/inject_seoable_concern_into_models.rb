Rails.configuration.to_prepare do
  Cmor::Seo::Configuration.resources.keys.each do |resource_class|
    puts "[Cmor::Seo] Including Models::SeoableConcern in #{resource_class}"
    resource_class.constantize.send(:include, Cmor::Seo::Models::SeoableConcern)
    puts " -> [OK]"
  end
end