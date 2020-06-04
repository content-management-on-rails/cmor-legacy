module Cmor::Transports
  class ExportsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::AasmConcern

    def self.resource_class
      Cmor::Transports::Export
    end

    private

    def after_create_location
      url_for(:back)
    end
  end
end
