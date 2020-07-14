# frozen_string_literal: true

module Cmor::Transports
  class ExportsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::AasmConcern

    def self.resource_class
      Cmor::Transports::Export
    end

    private
    def permitted_params
      params.require(:export).permit(:root_model, :query, :count_query, :output_format, :description, output_attributes: [])
    end

    def after_create_location
      if last_location.start_with?(url_for)
        url_for(@resource)
      else
        last_location
      end
    end
  end
end
