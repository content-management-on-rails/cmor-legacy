module Cmor
  module Restaurant
    module Api
      class CategoriesController < ResourcesController::Base
        def self.resource_class
          Cmor::Restaurant::Category
        end

        def self.serializer_class
          Cmor::Restaurant::Api::CategorySerializer
        end

        private

        def default_query_params_exceptions
          super << "populate"
        end
      end
    end
  end
end
