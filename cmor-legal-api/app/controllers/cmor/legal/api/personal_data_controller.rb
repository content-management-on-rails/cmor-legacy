module Cmor::Legal::Api
  class PersonalDataController < Cmor::Legal::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Legal::PersonalData
    end

    def self.serializer_class
      Cmor::Legal::Api::PersonalDataSerializer
    end
  end
end
