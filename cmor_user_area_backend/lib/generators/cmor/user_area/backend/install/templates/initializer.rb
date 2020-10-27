Cmor::UserArea::Backend.configure do |config|  
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[
  #            Cmor::UserArea::Backend::UsersController
  #          ]}
  # 
  config.resources_controllers = -> {[
    Cmor::UserArea::Backend::UsersController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.service_controllers = -> {[
  #            Cmor::UserArea::Backend::CreateDefaultUserServiceController
  #          ]}
  # 
  config.service_controllers = -> {[
    Cmor::UserArea::Backend::CreateDefaultUserServiceController
  ]}

  # Set the sidebars, that will be shown in the backend menu.
  # 
  # Default: config.sidebar_controllers = -> {[
  #            Cmor::UserArea::Backend::UserSidebarsController
  #          ]}
  # 
  config.sidebar_controllers = -> {[
    Cmor::UserArea::Backend::UserSidebarsController
  ]}

  # Enable/disable the two factor authentication backend.
  #
  # default: config.enable_tfa = -> { true }
  #
  config.enable_tfa = -> { true }
end