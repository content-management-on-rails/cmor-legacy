module Cmor
  module Legal
    class PrivacyPoliciesController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Cmor::Legal::PrivacyPolicy
      end

      private

      def permitted_params
        params.require(:privacy_policy).permit(:locale, :meta_description, :body, :format, :handler)
      end
    end
  end
end
