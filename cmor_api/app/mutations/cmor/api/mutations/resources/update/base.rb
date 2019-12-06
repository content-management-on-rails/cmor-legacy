module Cmor
  module Api
    module Mutations
      module Resources
        module Update
          class Base < GraphQL::Schema::RelayClassicMutation
            include Cmor::Api::Mutations::UserErrorHandlingConcern
            module ResourceHandlingConcern
              extend ActiveSupport::Concern

              class_methods do
                def resource_class
                  raise "Child class responsibility"
                end

                def resource_field_name
                  resource_class.name.demodulize.underscore
                end

                def resource_field_type
                  raise "Child class responsibility"
                end

                def initialize!
                  field resource_field_name, resource_field_type, null: true
                end
              end
          
              def resolve(*args)
                @attributes = args[0]
                @id = @attributes.delete(:id)
                before_resolve if respond_to?(:before_resolve, true)

                load_resource
                result = if @resource.update(@attributes)
                  {
                    resource_field_name => @resource,
                    errors: []
                  }
                else
                  {
                    errors: build_user_errors_from_resource(@resource)
                  }
                end
                result
              end

              private

              def params
                @params
              end

              def build_user_errors_from_resource(resource)
                # Convert Rails model errors into GraphQL-ready error hashes
                resource.errors.map do |attribute, message|
                  # This is the GraphQL argument which corresponds to the validation error:
                  path = ["attributes", attribute.to_s.camelize(:lower)]
                  {
                    path: path,
                    message: message,
                  }
                end
              end

              def resource_class
                self.class.resource_class
              end

              def resource_field_name
                self.class.resource_field_name
              end

              def load_resource
                @resource = resource_class.find(@id)
              end
            end

            include ResourceHandlingConcern
          end
        end
      end
    end
  end
end
