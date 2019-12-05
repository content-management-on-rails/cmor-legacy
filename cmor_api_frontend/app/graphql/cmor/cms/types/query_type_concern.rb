module Cmor
  module Cms
    module Types
      module QueryTypeConcern
        extend ActiveSupport::Concern

        included do
          # queries are just represented as fields
          # `all_links` is automatically camelcased to `allLinks`
          field :all_pages, [::Cmor::Cms::Types::PageType], null: false
          field :page, [::Cmor::Cms::Types::PageType], null: false
        end

        # this method is invoked, when `all_link` fields is being resolved
        def all_pages
          Cmor::Cms::Page.all
        end

        def page(id:)
          Cmor::Cms::Page.find(id)
        end
      end
    end
  end
end
