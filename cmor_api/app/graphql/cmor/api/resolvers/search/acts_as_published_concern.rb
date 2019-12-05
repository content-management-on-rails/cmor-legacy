module Cmor
  module Api
    module Resolvers
      module Search
        module ActsAsPublishedConcern
          extend ActiveSupport::Concern

          included do
            option(:published, type: GraphQL::Schema::Object::Boolean) { |scope, value| value ? scope.published : scope.unpublished }
          end
        end
      end
    end
  end
end
