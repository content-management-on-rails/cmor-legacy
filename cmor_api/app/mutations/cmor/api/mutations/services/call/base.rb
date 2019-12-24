module Cmor
  module Api
    module Mutations
      module Services
        module Call
          class Base < GraphQL::Schema::RelayClassicMutation
            include Cmor::Api::Mutations::UserErrorHandlingConcern
            
            module ServiceHandlingConcern
              extend ActiveSupport::Concern

              class_methods do
                def service_class
                  raise "Child class responsibility"
                end

                def initialize!
                  argument :attributes, GraphQL::Types::JSON, required: true
                  argument :options, GraphQL::Types::JSON, required: true

                  field :success, Cmor::Api::Mutations::Services::Call::Base::Boolean, null: false
                  field :status, String, null: false
                  field :messages, [Cmor::Api::Service::MessageType::Base], null: true
                end
              end
          
              def resolve(*args)
                before_resolve if respond_to?(:before_resolve, true)
                attributes, options = extract_attributes_and_options_from_args(args)
                service = initialize_service_for_perform(attributes, options)
                result = perform(service)

                result.as_json(except: %w(service errors)).merge(success: result.success?, status: (result.success? ? :success : :failed), errors: build_user_errors_from_result(result))
              end

              private

              def extract_attributes_and_options_from_args(args)
                return args[0][:attributes], args[0][:options]
              end

              def build_user_errors_from_result(result)
                # Convert Rails model errors into GraphQL-ready error hashes
                result.errors.map do |attribute, message|
                  # This is the GraphQL argument which corresponds to the validation error:
                  path = ["attributes", attribute.to_s.camelize(:lower)]
                  {
                    path: path,
                    message: message,
                  }
                end
              end
              # def build_messages_from_result(result)
              #   result.messages.map do |message|
              #     path = ["attributes", attribute.to_s.camelize(:lower)]
              #     {
              #       path: path,
              #       message: message,
              #     }
              #   end
              # end

              def service_class
                self.class.service_class
              end

              def service_field_name
                self.class.service_field_name
              end

              def initialize_service_for_perform(attributes, options)
                service_class.new(attributes, options)
              end

              def perform(service)
                service.perform
              end
            end

            include ServiceHandlingConcern
          end
        end
      end
    end
  end
end
