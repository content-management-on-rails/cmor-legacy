module Cmor::Showcase::Api
  class ItemsController < Cmor::Showcase::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Showcase::Item
    end

    def self.serializer_class
      Cmor::Showcase::Api::ItemSerializer
    end
  end
end
