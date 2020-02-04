FactoryBot.define do
  factory :cmor_legal_privacy_policy, class: Cmor::Legal::PrivacyPolicy do
    locale { I18n.locale }
  end
end
