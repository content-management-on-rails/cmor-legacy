Cmor::Blog::Backend.configure do |config|  
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::Blog::Backend::PostsController,
  #            Cmor::Blog::Backend::AssetDetailsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::Blog::Backend::PostsController,
    Cmor::Blog::Backend::AssetDetailsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}

  # This proc is used in context of the PostsController to retrieve the current
  # user to userstamp created/updated posts.
  #
  # default: config.current_user_proc = ->(controller) { controller.send(:current_user) }
  #
  config.current_user_proc = ->(controller) { controller.send(:current_user) }
end