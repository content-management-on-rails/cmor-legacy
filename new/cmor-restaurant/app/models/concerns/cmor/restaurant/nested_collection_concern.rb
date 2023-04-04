module Cmor
  module Restaurant
    module NestedCollectionConcern
      extend ActiveSupport::Concern

      included do
        acts_as_nested_set
        default_scope { order(:lft) }
      end
    end
  end
end
