module Cmor
  module Api
    module Types
      module Resource
        class Base < Cmor::Api::Types::BaseObject
          TYPE_MAP = {
            id: GraphQL::Types::ID,
            string: String,
            integer: GraphQL::Types::Int,
            text: String,
            datetime: GraphQL::Types::ISO8601DateTime,
            boolean: Boolean
          }

          # field :id, ID, null: false
          # field :title, String, null: false
          # field :body, String, null: false
          # field :pathname, String, null: false
          # field :basename, String, null: false
          # field :format, String, null: true
          # field :handler, String, null: false
          
          def self.infer_fields_from_resource_class!(always_allow_null: false)
            resource_class.columns.each do |c|
              begin
                if c.name.end_with?('id') && c.type == :integer
                  self.field c.name, TYPE_MAP[:id], null: c.null
                  puts "[#{self.name}] Add field :#{c.name}, #{TYPE_MAP[:id]}, null: #{(always_allow_null ? true : c.null)}"
                else
                  self.field c.name, TYPE_MAP[c.type], null: c.null
                  puts "[#{self.name}] Add field :#{c.name}, #{TYPE_MAP[c.type]}, null: #{(always_allow_null ? true : c.null)}"
                end
              rescue => e
                binding.pry
              end
            end
          end

          # module FilteringConcern
          #   extend ActiveSupport::Concern

          #   include SearchObject.module(:graphql)

          #   included do
          #     scope { base_scope.all }

          #     # option(:name, type: String)       { |scope, value| scope.where name: value }
          #     # option(:published, type: Boolean) { |scope, value| value ? scope.published : scope.unpublished }
          #   end

          #   class_methods do
          #     def base_scope
          #       resource_class
          #     end
          #   end
          # end

          # include FilteringConcern
        end
      end
    end
  end
end
