Cmor::Galleries.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # These options are the defaults that will be applied to when rendering
  # galleries through the galleries helper.
  #
  #  Default: config.galleries_helper_render_default_options = { variant_options: {}, show_details: false }
  #
  config.galleries_helper_render_default_options = { variant_options: {}, show_details: false }

  # These options are the defaults that will be applied to when rendering
  # pictures through the pictures helper.
  #
  #  Default: config.pictures_helper_render_default_options = { image_tag_only: true }
  #
  config.pictures_helper_render_default_options = { image_tag_only: true }

  # This options will be applied when rendering thumbails in galleries.
  #
  # Default: config.thumbnail_variant_options = { resize: "384x216^", extent: "384x216", gravity: "center" }
  #
  config.thumbnail_variant_options = { resize: "384x216^", extent: "384x216", gravity: "center" }
end
