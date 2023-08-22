Cmor::Links.configure do |config|
  # Set the resources, that will be shown in the backend menu in development
  # mode. This needs to be set to get a correct menu because
  # Controller.descendants is empty in development. This is an eager load
  # issue.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::Links::CategoriesController,
  #            Cmor::Links::LinksController
  #          ]}
  #
  config.resources_controllers = lambda {
    [
      Cmor::Links::CategoriesController,
      Cmor::Links::LinksController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[]}
  #
  config.service_controllers = -> { [] }

  # Configure your link footer columns here.
  #
  # Default: config.link_footer_columns = 4
  #
  config.link_footer_columns = 4
end
