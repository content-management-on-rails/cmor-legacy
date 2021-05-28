# frozen_string_literal: true

module Cmor
  module Legal
    module Frontend
      class PrivacyPoliciesController < Cmor::Legal::Frontend::Configuration.base_controller.constantize
        if Cmor::Legal::Configuration.integrate_with_cmor_cms?
          prepend_view_path ::Cmor::Legal::PrivacyPolicyResolver.instance unless view_paths.include?(::Cmor::Legal::PrivacyPolicyResolver.instance)
        end

        def show
          render "/cmor/legal/privacy_policy"
        end
      end
    end
  end
end
