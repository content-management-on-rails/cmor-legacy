# frozen_string_literal: true

module Cmor
  module Legal
    module Frontend
      class PrivacyPoliciesController < Cmor::Legal::Frontend::Configuration.base_controller.constantize
        prepend_view_path ::Cmor::Legal::PrivacyPolicyResolver.instance unless view_paths.include?(::Cmor::Legal::PrivacyPolicyResolver.instance)

        def show
          render "/cmor/legal/privacy_policy"
        end
      end
    end
  end
end
