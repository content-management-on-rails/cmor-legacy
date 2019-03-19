Cmor::Files::Backend.configure do |config|  
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::Files::Backend::FoldersController,
  #            Cmor::Files::Backend::FileDetailsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::Files::Backend::FoldersController,
    Cmor::Files::Backend::FileDetailsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}
end