Cmor::Blog.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '::ApplicationController'
  #
  config.base_controller = '::ApplicationController'

  # Class to use for creators and updaters.
  #
  # default: config.creator_class_name = 'User'
  #
  config.creator_class_name = 'User'

  # Factory name to use for creators and updaters.
  #
  # default: config.user_factory_name = 'user' 
  #
  config.user_factory_name = 'user'

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
  # Default: config.preview_picture_asset_variant_options = { resize: '320x240' }
  #
  config.preview_picture_asset_variant_options = { resize: '320x240' }

  # Enables the Cmor::Comments integration
  #
  # config.enable_feature :cmor_comments, {}

  # Enables the Cmor::Tags integration
  #
  # config.enable_feature :cmor_tags, {}

  # Method to call on creator for display.
  #
  # default: config.creator_label_method_name = :to_s
  #
  config.creator_label_method_name = :to_s
end
