# frozen_string_literal: true

module Cmor
  module Transports
    module Models
      module UuidConcern
        extend ActiveSupport::Concern

        included do
          after_initialize :set_uuid, if: :new_record?
        end

        private
        def set_uuid
          self.uuid ||= SecureRandom.uuid
        end
      end
    end
  end
end
