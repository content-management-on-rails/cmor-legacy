module Cmor
  module Legal
    class PrivacyPoliciesController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsPublishedConcern

      def self.resource_class
        Cmor::Legal::PrivacyPolicy
      end

      private

      def permitted_params
        params.require(:privacy_policy).permit(:locale, :meta_description, :title, :body, :format, :handler, :published)
      end
    end
  end
end
