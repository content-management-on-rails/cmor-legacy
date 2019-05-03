module Cmor::Partners
  class PartnersController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Partners::Partner
    end

    private

    def permitted_params
      params.require(:partner).permit(:category_id, :identifier, :name, :body, :published, :logo)
    end
  end
end