module Cmor::Links::Api
  class CategoriesController < Cmor::Links::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Links::Category
    end

    def self.serializer_class
      Cmor::Links::Api::CategorySerializer
    end

    private

    def load_collection_scope
      super.includes(:links)
    end

    def query_params_exceptions
      super + %w(populate)
    end

    def permitted_params
      params
        .require(:category)
        .permit(:parent_id, :locale, :name, :short_description, :long_description, :link_footer_column, :identifier)
    end
  end
end
