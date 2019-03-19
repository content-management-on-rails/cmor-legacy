Cmor::Contact::Backend.configure do |config|  
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::Contact::Backend::ContactRequestsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::Contact::Backend::ContactRequestsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}
end