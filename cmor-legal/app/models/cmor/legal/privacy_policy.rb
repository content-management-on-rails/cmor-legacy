# frozen_string_literal: true

module Cmor
  module Legal
    if Cmor::Legal::Configuration.integrate_with_cmor_cms?
      class PrivacyPolicy < Cmor::Cms::Page
        after_initialize :set_defaults, if: :new_record?
        before_validation :set_locale_dependent_defaults, if: :new_record?

        default_scope { where(pathname: "/cmor/legal/", basename: "privacy_policy") }

        private

        def set_defaults
          self.pathname ||= "/cmor/legal/"
          self.basename ||= "privacy_policy"
          self.handler ||= "textile"
          self.published_at ||= Time.zone.now
        end

        def set_locale_dependent_defaults
          return unless locale.present?
          self.title ||= I18n.with_locale(locale) { I18n.t("cmor.legal.privacy_policy.default_title") }
        end
      end
    else
      class PrivacyPolicy; end
    end
  end
end
