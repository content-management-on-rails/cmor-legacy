Cmor::Links.configure do |config|
  # Configure your link footer columns here.
  #
  # Default: config.link_footer_columns = 4
  #
  config.link_footer_columns = 4

  # Configure your link footer wrapper css classes here.
  #
  # Default: config.link_footer_wrapper_css_classes = %w( row link-footer )
  #
  config.link_footer_wrapper_css_classes = %w( row link-footer )

  # Configure your link footer colum css classes here.
  #
  # Default: config.link_footer_column_css_classes = %w( link-footer-column col-lg-3 )
  #
  config.link_footer_column_css_classes = %w( link-footer-column col-lg-3 )

  # Set the base controller for the contact form
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'
end
