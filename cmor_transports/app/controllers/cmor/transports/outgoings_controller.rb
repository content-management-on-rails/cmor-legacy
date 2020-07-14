# frozen_string_literal: true

module Cmor::Transports
  class OutgoingsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::AasmConcern

    def self.resource_class
      Cmor::Transports::Outgoing
    end

    private
    def permitted_params
      params.require(:outgoing).permit(export_ids: [], system_ids: [])
    end
  end
end
