require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Core
    module Backend
      module Configuration
        extend self

        def configure
          yield self
        end

        mattr_accessor :sidebar_controllers do
          -> {[]}
        end

        mattr_accessor(:image_variant_options) {
          {
            gallery: { resize: "640x480" },
            table:   { resize: "160x120" }
          }
        }

        mattr_accessor(:resources_routes) { {} }

        def image_variant_options_for(identifier)
          image_variant_options[identifier]
        end

        # You can add routes to resources based an any condition that can based
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
        def add_resources_routes(name, options)
          resources_routes[name] = options
        end

        mattr_accessor :cmor do
          Cmor
        end
      end
    end
  end
end
