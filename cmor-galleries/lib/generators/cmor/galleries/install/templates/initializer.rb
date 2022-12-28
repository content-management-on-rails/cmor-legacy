Cmor::Galleries.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #          ]}
  #
  config.resources_controllers = -> {
    []
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[]}
  #
  config.service_controllers = -> { [] }
end
