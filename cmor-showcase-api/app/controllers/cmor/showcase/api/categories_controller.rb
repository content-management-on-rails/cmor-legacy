module Cmor::Showcase::Api
  class CategoriesController < Cmor::Showcase::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Showcase::Category
    end

    def self.serializer_class
      Cmor::Showcase::Api::CategorySerializer
    end
  end
end
