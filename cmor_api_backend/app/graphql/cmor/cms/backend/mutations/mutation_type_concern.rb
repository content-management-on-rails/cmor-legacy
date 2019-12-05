module Cmor
  module Cms
    module Backend
      module Mutations
        module MutationTypeConcern
          extend ActiveSupport::Concern

          included do
            field :create_page, mutation: Cmor::Cms::Backend::Mutations::CreatePage
          end
        end
      end
    end
  end
end
