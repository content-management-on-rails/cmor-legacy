module Cmor
  module Api
    module Backend
      class Mutations < GraphQL::Schema::Object
        def self.mutations
          Cmor::Api::Backend::Configuration.mutations.merge(Cmor::Api::Backend::Configuration.services)
        end

        mutations.each do |class_name, options|
          field options[:field_name], mutation: class_name.constantize
        end
      end
    end
  end
end
