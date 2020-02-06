module Cmor
  module Legal
    class PrivacyPolicy < Cmor::Cms::Page
      after_initialize :set_defaults, :if => :new_record?
      before_validation :set_locale_dependent_defaults, :if => :new_record?

      default_scope { where(:pathname => '/cmor/legal/', :basename => 'show') }

      private

      def set_defaults
        self.pathname ||= '/cmor/legal/'
        self.basename ||= 'privacy_policy'
        self.handler  ||= 'textile'
      end

      def set_locale_dependent_defaults
        return unless self.locale.present?
        self.title    ||= I18n.with_locale(self.locale) { I18n.t('cmor.legal.privacy_policy.default_title') }
      end
    end
  end
end
