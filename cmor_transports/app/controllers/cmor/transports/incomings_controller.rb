# frozen_string_literal: true

module Cmor::Transports
  class IncomingsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::AasmConcern

    def self.resource_class
      Cmor::Transports::Incoming
    end

    private
    def permitted_params
      params.require(:incoming).permit()
    end
  end
end
