module Cmor
  module UserArea
    module Backend
      module Types
        class AuthType < Cmor::Api::Types::BaseObject
          field :token, String, null: false
        end
      end
    end
  end
end
