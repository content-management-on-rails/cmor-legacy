module Cmor
  module Api
    module Backend
      class Queries < GraphQL::Schema::Object
        def self.model_class_names
          Cmor::Api::Backend::Configuration.models
        end

        model_class_names.each do |model_class_name|
          method_name = model_class_name.demodulize.underscore.pluralize.to_sym
          type = "#{model_class_name}Type"
          # queries are just represented as fields
          # `all_links` is automatically camelcased to `allLinks`
          puts "field #{method_name}, [#{type}], null: false"
          field method_name, [type], null: false

          # this method is invoked, when `all_link` fields is being resolved
          define_method method_name do
            model_class_name.constantize.all
          end
        end

        # def self.service_class_names
        #   Cmor::Api::Backend::Configuration.services
        # end

        # service_class_names.each do |service_class_name|
        #   method_name = service_class_name.demodulize.underscore.pluralize.to_sym
        #   type = "#{service_class_name}Type"
        #   # queries are just represented as fields
        #   # `all_links` is automatically camelcased to `allLinks`
        #   puts "field #{method_name}, [#{type}], null: false"
        #   field method_name, [type], null: false

        #   # this method is invoked, when `all_link` fields is being resolved
        #   define_method method_name do
        #     service_class_name.constantize.all
        #   end
        # end
      end
    end
  end
end
