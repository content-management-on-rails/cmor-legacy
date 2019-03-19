module Model
  module Cmor
    module Tags
      module TaggableConcern
        extend ActiveSupport::Concern

        included do
          acts_as_taggable
        end
      end
    end
  end
end
