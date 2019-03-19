Cmor::Cms::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu in development
  # mode. This needs to be set to get a correct menu because
  # Controller.descendants is empty in development. This is an eager load
  # issue.
  #
  # Default: config.registered_controllers = []
  #
  config.registered_controllers = proc {
    [
      Cmor::Cms::Backend::ContentBoxesController,
      Cmor::Cms::Backend::NavigationItemsController,
      Cmor::Cms::Backend::NavigationsController,
      Cmor::Cms::Backend::PagesController,
      Cmor::Cms::Backend::PartialsController,
      Cmor::Cms::Backend::TemplatesController
    ]
  }
end
