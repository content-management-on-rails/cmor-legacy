FactoryBot.define do
  factory :cmor_core_api_api_token, class: Cmor::Core::Api::ApiToken do
    sequence(:description) { |i| "Api token ##{i}" }
  end
end
