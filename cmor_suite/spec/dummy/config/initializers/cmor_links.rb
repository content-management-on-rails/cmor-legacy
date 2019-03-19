Cmor::Links.configure do |config|
  # Configure your link footer columns here.
  #
  # Default: config.link_footer_columns = 4
  #
  config.link_footer_columns = 4

  # Configure your link footer colum css classes here.
  #
  # Default: config.link_footer_column_css_classes = %w[ link-footer-column col-lg-3 ]
  #
  config.link_footer_column_css_classes = %w( link-footer-column col-lg-3 )

  # Set the base controller for the contact form
  #
  # Default: config.base_controller = '::FrontendController'
  #
  config.base_controller = '::FrontendController'

  # Accepted markup languages
  #
  # default: config.markup_languages = %w[ textile ]
  config.markup_languages = %w( textile )

  # Default markup language
  #
  # default: config.default_markup_language = 'textile'
  config.default_markup_language = 'textile'
end
