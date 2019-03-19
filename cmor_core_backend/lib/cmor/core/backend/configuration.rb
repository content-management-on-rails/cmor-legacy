require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Core
    module Backend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :registered_controllers do
          lambda do
            [
              # Cmor::Contact::Backend::FoosController
            ]
          end
        end

        mattr_accessor :registered_services do
          lambda do
            []
          end
        end

        mattr_accessor(:enable_active_storage_backend) { false }
        mattr_accessor(:enable_delayed_job_backend) { false }

        def self.registered_controllers
          rc = @@registered_controllers.call
          rc.reject! { |c| c.name =~ /.*ActiveStorage.*/ } unless enable_active_storage_backend
          rc.reject! { |c| c.name =~ /.*Delayed.*/ } unless enable_delayed_job_backend
          -> { rc }
        end

        mattr_accessor(:image_variant_options) {
          {
            gallery: { resize: "640x480" },
            table:   { resize: "160x120" }
          }
        }

        def self.image_variant_options_for(identifier)
          @@image_variant_options[identifier]
        end
      end
    end
  end
end
