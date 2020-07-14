# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_import, class: Cmor::Transports::Import do
    root_model { "Post" }
  end
end
