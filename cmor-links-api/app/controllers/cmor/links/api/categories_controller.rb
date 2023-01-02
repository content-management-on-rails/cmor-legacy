module Cmor::Links::Api
  class CategoriesController < Cmor::Links::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Links::Category
    end

    def self.serializer_class
      Cmor::Links::Api::CategorySerializer
    end
  end
end
