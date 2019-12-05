module Cmor
  module Cms
    module Backend
      module Types
        module QueryTypeConcern
          extend ActiveSupport::Concern

          included do
            # queries are just represented as fields
            # `all_links` is automatically camelcased to `allLinks`
            field :pages, [::Cmor::Cms::Backend::Types::PageType], null: false
            field :page, [::Cmor::Cms::Backend::Types::PageType], null: false
          end

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
