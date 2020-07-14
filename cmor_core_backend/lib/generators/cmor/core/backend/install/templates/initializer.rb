Cmor::Core::Backend.configure do |config|
  # Globally set variant options to be used in backends.
  #
  # default: config.image_variant_options = {
  #            gallery: { resize: "640x480" },
  #            table:   { resize: "160x120" }
  #          }
  config.image_variant_options = {
    gallery: { resize: "640x480" },
    table:   { resize: "160x120" }
  }

  # You can add routes to resources based an any condition that is based
  # on the controller or resource class that a route is used for.
  #
  # This is useful when writing modules that conditionally add actions to
  # resources based on the capabilities of the controller or resource class.
  #
  # Example:
  #
  #     config.add_resources_routes(
  #       :cmor_audits,
  #       condition: ->{ resource_class.ancestors.map(&:to_s).include?("PaperTrail::Model::InstanceMethods") },
  #       routes:    ->{ paper_trail_resources }
  #     )
  #
  # Example:
  #
  #     config.add_resources_routes(
  #       :acts_as_list,
  #       condition: ->{ resource_class.respond_to?(:position) },
  #       routes:    ->{ get :toggle_position, on: :member }
  #     )
  #
end