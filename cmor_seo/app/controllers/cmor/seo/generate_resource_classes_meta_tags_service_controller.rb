module Cmor::Seo
  class GenerateResourceClassesMetaTagsServiceController < Cmor::Core::Backend::ServiceController::Base
    def self.service_class
      Cmor::Seo::GenerateResourceClassesMetaTagsService
    end

    private

    def permitted_params
      params.require(:generate_resource_classes_meta_tags_service).permit(resource_classes: [])
    end
  end
end
