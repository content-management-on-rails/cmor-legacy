# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_legal_personal_data, class: Cmor::Legal::PersonalData do
    sequence(:root) { |i| "Model#{i}" }
    block { ->(record) {} }
  end
end
