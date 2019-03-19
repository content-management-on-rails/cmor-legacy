require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Blog
    module Backend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :registered_controllers do
          lambda do
            [
              Cmor::Blog::Backend::PostsController
            ]
          end
        end

        mattr_accessor :registered_services do
          lambda do
            []
          end
        end

        mattr_accessor(:current_user_proc) { ->(controller) { controller.current_user } }
      end
    end
  end
end
