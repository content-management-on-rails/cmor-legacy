module Cmor
  module Core
    module Backend
      module Routing
        # You can add routes to resources based an any condition that is based
        # on the controller or resource class that a route is used for.
        #
        # This is useful when writing modules that conditionally add actions to
        # resources based on the capabilities of the controller or resource class.
        #
        # Example:
        #
        #     # lib/cmor/audits/engine.rb (in the Cmor::Audits Engine)
        #     module Cmor::Audits
        #       class Engine < ::Rails::Engine
        #         config.to_prepare do
        #           Cmor::Core::Backend.configure do |config|
        #             config.add_resources_routes(
        #               :cmor_audits,
        #               condition: ->{ resource_class.ancestors.map(&:to_s).include?("PaperTrail::Model::InstanceMethods") },
        #               routes:    ->{
        #                 get "versions/:version_id", on: :member, action: :version
        #                 get "versions_at(/:version_at)", on: :member, action: :version_at
        #                 get "versions", on: :member, action: :versions
        #               }
        #             )
        #           end
        #         end
        #       end
        #     end
        #
        #     # config/routes.rb ( in the Cmor::Cms::Backend Engine)
        #     Cmor::Cms::Backend::Engine.routes.draw do
        #       resources :pages do
        #         Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
        #       end
        #     end
        #
        #
        # This will add the routes for the versioning to the pages resource
        # routing if the resource class of the pages controller includes the
        # PaperTrail::Model::InstanceMethods module.
        #
        class ResourcesRoutes
          def self.inject_routes(router, options = {})
            new(router, options).inject_routes
          end

          def initialize(router, options = {})
            @router = router
            @options = options
          end

          def inject_routes
            routes.each do |name, options|
              if instance_exec(&options[:condition])
                @router.instance_exec(&options[:routes])
              end
            end
          end

          def controller_class
            @controller_class ||= begin
              __controller = @router.instance_variable_get(:@scope).instance_variable_get(:@hash)[:controller]
              __namespaces = []
              __actual_scope = @router.instance_variable_get(:@scope)
              while __actual_scope.instance_variable_get(:@parent).present?
                __namespace = __actual_scope.instance_variable_get(:@parent).instance_variable_get(:@hash).try(:[], :module)
                if __namespace.present? && !__namespaces.any? { |n| n&.start_with?(__namespace) }
                  __namespaces << __actual_scope.instance_variable_get(:@parent).instance_variable_get(:@hash).try(:[], :module)
                end
                __actual_scope = __actual_scope.instance_variable_get(:@parent)
              end
              __namespace = __namespaces.uniq.reverse.compact.join("/")
              "#{__namespace}/#{__controller}_controller".camelize.constantize
            end
          end

          def resource_class
            controller_class.resource_class
          end

          def routes
            @routes ||= Cmor::Core::Backend::Configuration.resources_routes
          end
        end
      end
    end
  end
end
