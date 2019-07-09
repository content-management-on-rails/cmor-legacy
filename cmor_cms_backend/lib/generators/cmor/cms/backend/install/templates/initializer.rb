Cmor::Cms::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.registered_controllers = -> {[
  #            Cmor::Cms::Backend::ContentBoxesController,
  #            Cmor::Cms::Backend::NavigationsController,
  #            Cmor::Cms::Backend::NavigationItemsController,
  #            Cmor::Cms::Backend::PagesController,
  #            Cmor::Cms::Backend::PartialsController,
  #            Cmor::Cms::Backend::TemplatesController
  # ]}
  #
  config.registered_controllers = lambda {
    [
      Cmor::Cms::Backend::ContentBoxesController,
      Cmor::Cms::Backend::NavigationsController,
      Cmor::Cms::Backend::NavigationItemsController,
      Cmor::Cms::Backend::PagesController,
      Cmor::Cms::Backend::PartialsController,
      Cmor::Cms::Backend::TemplatesController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.registered_services = -> {[
  #            Cmor::Cms::AddHomepagesServiceController,
  #            Cmor::Cms::Backend::ImportPartialsServiceController
  #          ]}
  #
  config.registered_services = lambda {
    [
      Cmor::Cms::Backend::AddHomepagesServiceController,
      Cmor::Cms::Backend::ImportPartialsServiceController
    ]
  }
end
