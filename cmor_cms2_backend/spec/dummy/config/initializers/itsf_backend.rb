Itsf::Backend.configure do |config|
  # Set the base controller
  #
  # Default: config.base_controller = 'ApplicationController'
  #
  config.base_controller = '::ApplicationController'

  config.backend_engines = [
    Cmor::Cms::Backend::Engine
  ]
end
