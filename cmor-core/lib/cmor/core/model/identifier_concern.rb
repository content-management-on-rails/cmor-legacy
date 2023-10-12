module Cmor
  module Core
    module Model
      module IdentifierConcern
        extend ActiveSupport::Concern

        included do
          validates :identifier, uniqueness: {scope: [:locale]}, allow_nil: true, allow_blank: true
        end
      end
    end
  end
end
