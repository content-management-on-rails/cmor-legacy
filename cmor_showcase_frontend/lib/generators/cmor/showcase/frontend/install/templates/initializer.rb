Cmor::Showcase::Frontend.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Set the default ActiveStorage variant options for ApplicationHelper#render_partners.
  #
  # Default: config.default_render_items_variant_options = { combine_options: { resize: "768x432^", gravity: :center, extent: "768x432" } }
  #
  config.default_render_items_variant_options = { combine_options: { resize: "768x432^", gravity: :center, extent: "768x432" } }
end
