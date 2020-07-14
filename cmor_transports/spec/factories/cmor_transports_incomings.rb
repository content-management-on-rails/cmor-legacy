# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_incoming, class: Cmor::Transports::Incoming do
    outgoing_uuid { SecureRandom.uuid }
  end
end
