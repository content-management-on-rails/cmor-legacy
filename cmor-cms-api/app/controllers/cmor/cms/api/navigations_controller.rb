module Cmor::Cms::Api
  class NavigationsController < Cmor::Cms::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Cms::Navigation
    end

    def self.serializer_class
      Cmor::Cms::Api::NavigationSerializer
    end

    private

    def permitted_params
      params.require(:navigation)
            .permit(:locale, :name)
    end
  end
end
