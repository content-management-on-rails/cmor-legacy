module Cmor
  module MultiTenancy
    module Model
      module ClientConcern
        extend ActiveSupport::Concern

        included do
          belongs_to :client
          Client.has_many self.name.demodulize.underscore.pluralize.to_sym, class_name: self.name
        end
      end
    end
  end
end
