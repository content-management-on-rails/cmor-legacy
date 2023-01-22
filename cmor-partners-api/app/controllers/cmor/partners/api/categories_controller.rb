module Cmor::Partners::Api
  class CategoriesController < Cmor::Partners::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Partners::Category
    end

    def self.serializer_class
      Cmor::Partners::Api::CategorySerializer
    end

    private

    def permitted_params
      params.require(:category).permit(:locale, :identifier, :name, :body, :published)
    end
  end
end
