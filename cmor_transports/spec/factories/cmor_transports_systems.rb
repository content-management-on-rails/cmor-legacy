# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_system, class: Cmor::Transports::System do
    identifier { "staging" }
    endpoint { "http://localhost:3000/de/backend/transporte/api/" }
    api_key { "da39a3ee5e6b4b0d3255bfef95601890afd80709" }
  end
end
