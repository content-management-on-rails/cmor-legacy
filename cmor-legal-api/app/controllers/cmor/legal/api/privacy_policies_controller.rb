module Cmor::Legal::Api
  class PrivacyPoliciesController < Cmor::Legal::Api::ResourceController::Base
    def self.resource_class
      Cmor::Legal::PrivacyPolicy
    end

    def self.serializer_class
      Cmor::Legal::Api::PrivacyPolicySerializer
    end

    private

    def load_resource
      Cmor::Legal::PrivacyPolicy.first
    end
  end
end
