Cmor::Tags::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.registered_controllers = -> {[
  #            Cmor::Tags::Backend::TagsController,
  #            Cmor::Tags::Backend::TaggingsController
  # ]}
  #
  config.registered_controllers = lambda {
    [
      Cmor::Tags::Backend::TagsController,
      Cmor::Tags::Backend::TaggingsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.registered_services = -> {[
  #          ]}
  #
  config.registered_services = lambda {
    [
    ]
  }

  # Specify the models that can be tagged.
  #
  # Default: config.taggable_class_names = %w()
  #
  config.taggable_class_names = %w()

  # Specify the models the can tag things.
  #
  # Default: config.tagger_class_names = %w()
  #
  config.tagger_class_names = %w()
end
