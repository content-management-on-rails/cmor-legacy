module Cmor::Cms::Backend
  class ImportPartialsServiceController < Cmor::Core::Backend::ServiceController::Base
    def self.service_class
      Cmor::Cms::ImportPartialsService
    end

    private

    def permitted_params
      params.fetch(:import_partials_service, {}).permit
    end
  end
end
