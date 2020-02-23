Cmor::Blog.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Class to use for creators and updaters.
  #
  # default: config.creator_class_name = '<%= creator_class_name %>'
  #
  config.creator_class_name = '<%= creator_class_name %>'

  # Factory name to use for creators and updaters.
  #
  # default: config.user_factory_name = '<%= user_factory_name %>' 
  #
  config.user_factory_name = '<%= user_factory_name %>'

  # Set the page title for the posts index page. Useful for when you use
  # the blog posts index as main app root page.
  #
  # example: config.posts_index_page_title_proc = ->(view) { view.t('.welcome') }
  #
  # default: config.posts_index_page_title_proc = ->(view) { view.resource_class.model_name.human(count: :other) }
  #
  config.posts_index_page_title_proc = ->(view) { view.resource_class.model_name.human(count: :other) }

  # Set options that will be passed to the paginate call.
  #
  # example for bootstrap 3 (You will need to add the bootstrap3-kaminari-views gem to your Gemfile):
  #
  #    config.pagination_options_proc = ->(view) { { theme: 'twitter-bootstrap-3' }
  #
  # example for bootstrap 4 (You will need to add the bootstrap4-kaminari-views gem to your Gemfile):
  #
  #    config.pagination_options_proc = ->(view) { { theme: 'twitter-bootstrap-4' }
  #
  # default: config.pagination_options_proc = ->(view) { { theme: 'twitter-bootstrap-4', pagination_class: 'justify-content-center' } }
  #
  config.pagination_options_proc = ->(view) { { theme: 'twitter-bootstrap-4', pagination_class: 'justify-content-center' } }

  # ActiveStorage options for rendering preview pictures in the posts index and show view.
  #
  # Default: config.preview_picture_asset_variant_options = { combine_options: { resize: "320x240^", extent: "384x216", gravity: "center" } }
  #
  config.preview_picture_asset_variant_options = { combine_options: { resize: "320x240^", extent: "384x216", gravity: "center" } }

  # Define how the author will be shown on posts.
  #
  # You can generalize the label by not taking the creator into account at all:
  #
  #     config.creator_label_for_post_proc = -> (post) { "Site Owner" }
  #
  # You can show a default when the creator is not set:
  #
  #     config.creator_label_for_post_proc = -> (post) { post.creator&.to_s || "Site owner" }
  #
  # default: config.creator_label_for_post_proc = -> (post) { post.creator&.to_s }
  #
  config.creator_label_for_post_proc = -> (post) { post.creator&.to_s }
end
