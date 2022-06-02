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
  # Default: config.service_controllers = -> {[
  #            Cmor::Seo::GenerateResourceClassesMetaTagsServiceController,
  #          ]}
  #
  config.service_controllers = -> {[
      Cmor::Seo::GenerateResourceClassesMetaTagsServiceController,
  ]}

  # Set the sidebars, that will be shown in the backend menu.
  # 
  # Default: config.sidebar_controllers = -> {[]}
  config.sidebar_controllers = -> {[]}

  # This proc will handle any exception that happens in the after_save callback
  # that creates items and meta tags.
  #
  # Default: config.handle_seoable_after_save_exception = ->(exception) { raise exception }
  #
  config.handle_seoable_after_save_exception = ->(exception) { raise exception }

  # Set the resources that will be available as seo targets when creating new
  # Cmor::Seo::Items.
  #
  # Examples:
  #
  # config.add_resource(
  #   'Cmor::Blog::Post',
  #   title: ->(resource) { resource.title },
  #   meta_tags: -> {{
  #     'description' => ->(resource) { { content: resource.title } },
  #     'og:title'    => ->(resource) { { content: resource.title } },
  #     'og:url'      => ->(resource) { { content: cmor_blog.url_for(resource) } },
  #   }},
  #   autocomplete_options: {
  #     scope: ->(term) { Cmor::Blog::Post.where("LOWER(title) LIKE :term", term: "%#{term.downcase}%") },
  #     id_method: :id,
  #     text_method: :title
  #   }
  # )
  #
  # config.add_resource(
  #   'Cmor::Cms::Page',
  #   title: ->(resource) { resource.title },
  #   meta_tags: -> {{
  #     'description' => ->(resource) { { content: resource.meta_description } },
  #     'og:title'    => ->(resource) { { content: resource.title } },
  #   }},
  #   autocomplete_options: {
  #     scope: ->(term) { Cmor::Cms::Page.where("LOWER(title) LIKE :term", term: "%#{term.downcase}%") },
  #     id_method: :id,
  #     text_method: :title
  #   }
  # )
end
