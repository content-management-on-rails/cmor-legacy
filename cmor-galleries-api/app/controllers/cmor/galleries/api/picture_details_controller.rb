module Cmor::Galleries::Api
  class PictureDetailsController < Cmor::Galleries::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Galleries::PictureDetail
    end

    def self.serializer_class
      Cmor::Galleries::Api::PictureDetailSerializer
    end
  end
end
