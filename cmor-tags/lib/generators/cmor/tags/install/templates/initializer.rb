Cmor::Tags.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::Tags::TagsController,
  #            Cmor::Tags::TaggingsController
  # ]}
  #
  config.resources_controllers = lambda {
    [
      Cmor::Tags::TagsController,
      Cmor::Tags::TaggingsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[
  #          ]}
  #
  config.service_controllers = lambda {
    [
    ]
  }

  # Use exact search by default or not.
  #
  # Default: config.tag_search_exact_default_value = false
  #
  config.tag_search_exact_default_value = false

  # Specify the models the can tag things.
  #
  # Default: config.tagger_class_names = <%= tagger_class_names %>
  #
  config.tagger_class_names = <%= tagger_class_names %>

  # Specify the models to be tagged.
  #
  # Default: config.taggable_class_names = <%= taggable_class_names %>
  #
  config.taggable_class_names = <%= taggable_class_names %>

  # Factory name to use for taggable objects.
  #
  # Default: config.taggable_factory_name = <%= taggable_factory_name %>
  #
  config.taggable_factory_name = <%= taggable_factory_name %>
end
