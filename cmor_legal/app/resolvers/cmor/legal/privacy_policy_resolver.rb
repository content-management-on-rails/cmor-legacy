# frozen_string_literal: true

module Cmor
  module Legal
    if Cmor::Legal::Configuration.integrate_with_cmor_cms?
      class PrivacyPolicyResolver < Cmor::Cms::PageResolver
      end
    else
      class PrivacyPolicyResolver; end
    end
  end
end
