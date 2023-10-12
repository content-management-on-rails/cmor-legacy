FactoryBot.define do
  factory :cmor_core_settings_setting, class: Cmor::Core::Settings::Setting do
    namespace { "Foo::Bar" }
    sequence(:key) { |i| "key-#{i}" }
  end
end
