module Cmor
  module Api
    module ResourceType
      class Base < GraphQL::Schema::Object
        def self.resource_class
          raise "Child class responsibility."
        end

        TYPE_MAP = {
          id: GraphQL::Types::ID,
          string: String,
          integer: GraphQL::Types::Int,
          text: String,
          datetime: GraphQL::Types::ISO8601DateTime,
          boolean: Boolean
        }
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
      end
    end
  end
end
