module Cmor::Links::Api
  class LinksController < Cmor::Links::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Links::Link
    end

    def self.serializer_class
      Cmor::Links::Api::LinkSerializer
    end
  end
end
