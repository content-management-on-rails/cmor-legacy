Cmor::Core::Settings.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.register_engine("Cmor::Core::Settings::Engine", {})
  #
  config.cmor.administrador.register_engine("Cmor::Core::Settings::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::Core::Settings::SettablesController
  #          ]}
  #
  config.resources_controllers = -> {[
    Cmor::Core::Settings::SettablesController
  ]}
end
