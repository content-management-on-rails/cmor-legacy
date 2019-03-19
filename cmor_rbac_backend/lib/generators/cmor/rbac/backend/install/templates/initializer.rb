Cmor::Rbac::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.registered_controllers = lambda {
  #            [
  #              Cmor::Rbac::Backend::RolesController
  #            ]
  #          }
  #
  config.registered_controllers = lambda {
    [
      Cmor::Rbac::Backend::UsersController,
      Cmor::Rbac::Backend::RolesController,
      Cmor::Rbac::Backend::PermissionsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.registered_services = lambda {
  #            [
  #              Cmor::Rbac::Backend::ImportDefaultPermissionsServiceController
  #            ]
  #          }
  #
  config.registered_services = lambda {
    [
      Cmor::Rbac::Backend::ImportDefaultPermissionsServiceController
    ]
  }
end
