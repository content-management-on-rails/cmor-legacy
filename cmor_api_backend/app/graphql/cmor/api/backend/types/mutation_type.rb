module Cmor
  module Api
    module Backend
      module Types
        class MutationType < Cmor::Api::Types::BaseObject
          include Cmor::Blog::Backend::Mutations::MutationTypeConcern
          include Cmor::Cms::Backend::Mutations::MutationTypeConcern
          include Cmor::UserArea::Backend::Mutations::MutationTypeConcern
          # # TODO: remove me
          # field :test_field, String, null: false,
          #   description: "An example field added by the generator"
          # def test_field
          #   "Hello World"
          # end
        end
      end
    end
  end
end
