module Cmor::Carousels::Api
  class ItemDetailsController < Cmor::Carousels::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Carousels::ItemDetail
    end

    def self.serializer_class
      Cmor::Carousels::Api::ItemDetailSerializer
    end

    private

    def permitted_params
      params.require(:item_detail).permit(:carousel_id, :url, :description, :published, :asset)
    end
  end
end
