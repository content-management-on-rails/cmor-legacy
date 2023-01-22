module Cmor::Legal::Api
  class PrivacyPoliciesController < Cmor::Legal::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Legal::PrivacyPolicy
    end

    def self.serializer_class
      Cmor::Legal::Api::PrivacyPolicySerializer
    end

    private

    def permitted_params
      params.require(:privacy_policy).permit(:locale, :meta_description, :title, :body, :format, :handler, :published)
    end
  end
end
