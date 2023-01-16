module Cmor::Partners::Api
  class CategoriesController < Cmor::Partners::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Partners::Category
    end

    def self.serializer_class
      Cmor::Partners::Api::CategorySerializer
    end
  end
end
