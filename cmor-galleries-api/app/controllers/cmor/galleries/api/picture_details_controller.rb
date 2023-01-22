module Cmor::Galleries::Api
  class PictureDetailsController < Cmor::Galleries::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Galleries::PictureDetail
    end

    def self.serializer_class
      Cmor::Galleries::Api::PictureDetailSerializer
    end

    private

    def permitted_params
      params.require(:picture_detail).permit(:title, :identifier, :description, :picture_gallery_id, :published, :asset)
    end
  end
end
