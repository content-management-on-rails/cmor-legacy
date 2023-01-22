module Cmor::Showcase::Api
  class CategoriesController < Cmor::Showcase::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Showcase::Category
    end

    def self.serializer_class
      Cmor::Showcase::Api::CategorySerializer
    end

    private

    def permitted_params
      params.require(:category).permit(:locale, :identifier, :name, :body, :published, :image)
    end
  end
end
