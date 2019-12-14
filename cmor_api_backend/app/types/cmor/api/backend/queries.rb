module Cmor
  module Api
    module Backend
      class Queries < GraphQL::Schema::Object
        # {
        #   'Cmor::Blog::Backend' => {
        #     'Cmor::Blog::Post' => {}
        #   },
        #   'Cmor::Cms::Backend' => {
        #     'Cmor::Cms::Post' => {}
        #   },
        #   'Cmor::UserArea::Backend' => {
        #     'Cmor::UserArea::User'
        #   },
        # }
        %w(
          Cmor::Blog::Post
          Cmor::UserArea::User
          Cmor::Cms::Page
        ).each do |model_class_name|
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
      end
    end
  end
end
