FactoryBot.define do
  factory :cmor_system_changelog, class: 'Cmor::System::Changelog' do
    sequence(:id) { |i| "changelog_#{i}" }
    sequence(:name) { |i| "changelog_#{i}" }
    version { "1.0.0" }
    file { Cmor::System::Engine.root.join(*%w(spec files cmor system changelog file example.md)) }
  end
end
