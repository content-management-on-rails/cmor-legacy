module Cmor
  module Cms
    module Backend
      module Types
        module QueryTypes
          def self.register(query_type)
            # queries are just represented as fields
            # `all_links` is automatically camelcased to `allLinks`
            query_type.field :pages, [::Cmor::Cms::Backend::Types::PageType], null: false
            query_type.field :page, [::Cmor::Cms::Backend::Types::PageType], null: false

            query_type.send(:include, InstanceMethods)
          end

          module InstanceMethods
            # this method is invoked, when `all_link` fields is being resolved
            def pages
              Cmor::Cms::Page.all
            end

            def page(id:)
              Cmor::Cms::Page.find(id)
            end
          end
        end
      end
    end
  end
end
