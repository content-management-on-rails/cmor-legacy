Cmor::Galleries.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.cmor.administrador.register_engine("Cmor::Galleries::Engine", {})
  #
  config.cmor.administrador.register_engine("Cmor::Galleries::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::Galleries::PictureGalleriesController,
  #            Cmor::Galleries::PictureDetailsController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Cmor::Galleries::PictureGalleriesController,
      Cmor::Galleries::PictureDetailsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[]}
  #
  config.service_controllers = -> { [] }
end
