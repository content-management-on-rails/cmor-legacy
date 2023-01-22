module Cmor::Partners::Api
  class PartnersController < Cmor::Partners::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Partners::Partner
    end

    def self.serializer_class
      Cmor::Partners::Api::PartnerSerializer
    end

    private

    def permitted_params
      params.require(:partner).permit(:category_id, :identifier, :name, :body, :published, :logo)
    end
  end
end
