# frozen_string_literal: true

FactoryBot.define do
  factory :paper_trail_version, class: ::PaperTrail::Version do
    event { "create" }
    association(:item, factory: Cmor::Audits::Configuration.audited_factory_name)
  end
end
