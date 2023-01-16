module Cmor::Carousels::Api
  class ItemDetailsController < Cmor::Carousels::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Carousels::ItemDetail
    end

    def self.serializer_class
      Cmor::Carousels::Api::ItemDetailSerializer
    end
  end
end
