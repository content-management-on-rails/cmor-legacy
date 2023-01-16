Cmor::Seo.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #          ]}
  #
  config.resources_controllers = -> {
    [
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[
  #          ]}
  #
  config.service_controllers = -> {
    [
    ]
  }

  # Set the sidebars, that will be shown in the backend menu.
  #
  # Default: config.sidebar_controllers = -> {[
  #          ]}
  #
  config.sidebar_controllers = -> {
    [
    ]
  }

  # Class to use for creators and updaters.
  #
  # default: config.creator_class_name = '<%= creator_class_name %>'
  #
  config.creator_class_name = '<%= creator_class_name %>'

  # This proc is used in context of the ItemsController and MetaTagsController
  # to retrieve the current user to userstamp created/updated items/meta tags.
  #
  # default: config.current_user_proc = ->(controller) { controller.respond_to?(:current_user, true) ? controller.send(:current_user) : nil }
  #
  config.current_user_proc = ->(controller) { controller.respond_to?(:current_user, true) ? controller.send(:current_user) : nil }

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
