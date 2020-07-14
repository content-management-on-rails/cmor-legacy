# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_outgoing_export, class: Cmor::Transports::OutgoingExport do
    association(:outgoing, factory: :cmor_transports_outgoing)
    association(:export, factory: :cmor_transports_export)
  end
end
