module Cmor::Legal::Api
  class PersonalDataController < Cmor::Legal::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Legal::PersonalData
    end

    def self.serializer_class
      Cmor::Legal::Api::PersonalDataSerializer
    end

    private

    def permitted_params
      params.require(:personal_data_registry).permit()
    end
  end
end
