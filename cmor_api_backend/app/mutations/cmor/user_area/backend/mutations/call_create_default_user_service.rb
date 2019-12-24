module Cmor
  module UserArea
    module Backend
      module Mutations
        # Example:
        #
        # mutation {
        #   callCreateDefaultUserService(input: {attributes: {}, options: {}}) {
        #     success
        #     status
        #     errors {
        #       message
        #       path
        #     }
        #     messages {
        #       indentLevel
        #       prefix
        #       content
        #       suffix
        #     }
        #   }
        # }
        #
        class CallCreateDefaultUserService < Cmor::Api::Mutations::Services::Call::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.service_class
            Cmor::UserArea::CreateDefaultUserService
          end

          initialize!
        end
      end
    end
  end
end