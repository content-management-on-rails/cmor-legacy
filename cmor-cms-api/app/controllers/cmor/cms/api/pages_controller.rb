module Cmor::Cms::Api
  class PagesController < Cmor::Cms::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Cms::Page
    end

    def self.serializer_class
      Cmor::Cms::Api::PageSerializer
    end
  end
end
