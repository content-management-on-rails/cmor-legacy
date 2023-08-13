module Cmor::Cms
  class AddHomepagesServiceController < Cmor::Core::Backend::ServiceController::Base
    def self.service_class
      Cmor::Cms::AddHomepagesService
    end

    private

    def permitted_params
      params.require(:add_homepages_service).permit(locales: [])
    end
  end
end
