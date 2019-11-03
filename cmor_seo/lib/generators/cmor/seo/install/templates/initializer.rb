Cmor::Seo.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[
  #            Cmor::Seo::ItemsController,
  #            Cmor::Seo::MetaTagsController
  #          ]}
  # 
  config.resources_controllers = -> {[
    Cmor::Seo::ItemsController,
    Cmor::Seo::MetaTagsController
  ]}

  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resource_controllers = -> {[]}
  # 
  config.resource_controllers = -> {[]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.service_controllers = -> {[]}
  # 
  config.service_controllers = -> {[]}

  # Set the sidebars, that will be shown in the backend menu.
  # 
  # Default: config.sidebar_controllers = -> {[]}
  # 
  config.sidebar_controllers = -> {[]}

  # Set the resources that will be available as seo targets when creating new
  # Cmor::Seo::Items.
  #
  # Example:
  #
  # config.items_resource_autocomplete_options = {
  #   'Cmor::Blog::Post' => {
  #     scope: ->(term) { Cmor::Blog::Post.where("LOWER(title) LIKE :term", term: "%#{term.downcase}%") },
  #     id_method: :id,
  #     text_method: :title
  #   },
  #   'Cmor::Cms::Page' => {
  #     scope: ->(term) { Cmor::Cms::Page.where("LOWER(title) LIKE :term", term: "%#{term.downcase}%") },
  #     id_method: :id,
  #     text_method: :title
  #   }
  # }
  #
  # Default: config.items_resource_autocomplete_options = {}
  #
  config.items_resource_autocomplete_options = {}
end
