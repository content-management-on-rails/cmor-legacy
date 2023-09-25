module Cmor
  module MultiTenancy
    module Model
      module ClientConcern
        extend ActiveSupport::Concern

        included do
          belongs_to :client, class_name: "Cmor::MultiTenancy::Client"

          after_initialize :set_client, if: :new_record?

          validates :client, presence: { strict: true }

          scope :for_current_client, -> { where(client_id: Cmor::MultiTenancy.current_client.id) }

          default_scope -> { Cmor::MultiTenancy.current_client.present? ? for_current_client : all }
        end

        private

        def set_client
          self.client ||= Cmor::MultiTenancy.current_client
        end
      end
    end
  end
end
