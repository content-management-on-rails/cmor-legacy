Cmor::Carousels::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.registered_controllers = -> {[
  #            Cmor::Carousels::Backend::CarouselsController,
  #            Cmor::Carousels::Backend::ItemDetailsController
  #          ]}
  #
  config.registered_controllers = lambda {
    [
      Cmor::Carousels::Backend::CarouselsController,
      Cmor::Carousels::Backend::ItemDetailsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.registered_services = -> {[]}
  #
  config.registered_services = -> { [] }
end
