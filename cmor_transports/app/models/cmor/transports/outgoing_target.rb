# frozen_string_literal: true

module Cmor::Transports
  class OutgoingTarget < ApplicationRecord
    belongs_to :outgoing
    belongs_to :system

    delegate :identifier, :endpoint, :api_key, to: :system, prefix: true, allow_nil: true
    delegate :uuid, to: :outgoing, prefix: true, allow_nil: true

    def incoming_status
      result = Cmor::Transports::Transfers::Api::IncomingStateService.call(system_identifier: system_identifier, endpoint: system_endpoint, api_key: system_api_key, outgoing_uuid: outgoing_uuid)
      if result.ok?
        result.incoming
      else
        nil
      end
    end
  end
end
