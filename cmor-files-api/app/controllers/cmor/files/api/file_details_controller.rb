module Cmor::Files::Api
  class FileDetailsController < Cmor::Files::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Files::FileDetail
    end

    def self.serializer_class
      Cmor::Files::Api::FileDetailSerializer
    end
  end
end
