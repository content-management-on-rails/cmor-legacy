# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_outgoing_target, class: Cmor::Transports::OutgoingTarget do
    association(:outgoing, factory: :cmor_transports_outgoing)
    association(:system, factory: :cmor_transports_system)
  end
end
