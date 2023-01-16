module Cmor::Seo::Api
  class ItemsController < Cmor::Seo::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Seo::Item
    end

    def self.serializer_class
      Cmor::Seo::Api::ItemSerializer
    end
  end
end
