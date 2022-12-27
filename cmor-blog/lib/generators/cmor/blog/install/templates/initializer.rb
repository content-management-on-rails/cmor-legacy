Cmor::Blog.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::Blog::PostsController,
  #            Cmor::Blog::AssetDetailsController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Cmor::Blog::PostsController,
      Cmor::Blog::AssetDetailsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[]}
  #
  config.service_controllers = -> { [] }

  # This proc is used in context of the PostsController to retrieve the current
  # user to userstamp created/updated posts.
  #
  # default: config.current_user_proc = ->(controller) { controller.respond_to?(:current_user, true) ? controller.send(:current_user) : nil }
  #
  config.current_user_proc = ->(controller) { controller.respond_to?(:current_user, true) ? controller.send(:current_user) : nil }

  # Factory name to use for creators and updaters.
  #
  # default: config.user_factory_name = '<%= user_factory_name %>'
  #
  config.user_factory_name = "<%= user_factory_name %>"

  # Class to use for creators and updaters.
  #
  # default: config.creator_class_name = '<%= creator_class_name %>'
  #
  config.creator_class_name = "<%= creator_class_name %>"
end
