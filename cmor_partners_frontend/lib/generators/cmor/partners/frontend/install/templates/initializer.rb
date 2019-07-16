Cmor::Partners::Frontend.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Set the default ActiveStorage variant options for ApplicationHelper#render_partners.
  #
  # Default: config.default_render_partners_variant_options = { resize: "512x256>", gravity: :center, extent: "512x256" }
  #
  config.default_render_partners_variant_options = { resize: "512x256>", gravity: :center, extent: "512x256" }
end
