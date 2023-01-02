# frozen_string_literal: true

module Cmor
  module Legal
    class PersonalDataController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Cmor::Legal::PersonalData
      end

      def self.available_rest_actions
        super - %i[edit new]
      end

      private

      def load_collection
        @collection = Kaminari.paginate_array(load_collection_scope.all).page(params[:page])
      end

      def permitted_params
        params.require(:personal_data_registry).permit
      end
    end
  end
end
