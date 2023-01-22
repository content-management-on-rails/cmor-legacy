module Cmor::Links::Api
  class LinksController < Cmor::Links::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Links::Link
    end

    def self.serializer_class
      Cmor::Links::Api::LinkSerializer
    end

    private

    def permitted_params
      params
        .require(:link)
        .permit(:category_id, :name, :url, :description, :identifier)
    end
  end
end
