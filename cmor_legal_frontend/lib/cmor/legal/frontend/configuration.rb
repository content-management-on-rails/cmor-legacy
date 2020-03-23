# frozen_string_literal: true

module Cmor
  module Legal
    module Frontend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor(:base_controller) { "::FrontendController" }

        mattr_accessor(:cookies_consent_banner_modal_class) { 'modal fade cookies-eu js-cookies-eu' }
        mattr_accessor(:cookies_consent_banner_modal_dialog_class) { 'modal-lg modal-dialog' }
      end
    end
  end
end
