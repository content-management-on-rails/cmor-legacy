Administrador.configure do |config|
  
  # Methods, that will be tried on a resource to generate a nice title
  # 
  # Default: config.resource_label_methods = [:human, :name, :email, :to_s]
  # 
  config.resource_label_methods = [:human, :name, :email, :to_s]

  # config.register_engine 'Cmor::Blog::Backend::Engine', {}
end
