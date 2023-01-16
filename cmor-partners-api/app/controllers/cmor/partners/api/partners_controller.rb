module Cmor::Partners::Api
  class PartnersController < Cmor::Partners::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Partners::Partner
    end

    def self.serializer_class
      Cmor::Partners::Api::PartnerSerializer
    end
  end
end
