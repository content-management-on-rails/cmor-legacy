module Cmor
  module MultiTenancy
    module Model
      module ClientConcern
        extend ActiveSupport::Concern

        included do
          belongs_to :client
        end
      end
    end
  end
end
