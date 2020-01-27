FactoryBot.define do
  factory :active_storage_attachment, class: 'ActiveStorage::Attachment' do
    association(:record, factory: Cmor::System::Backend::Configuration.record_factory_name)
    association(:blob, factory: :active_storage_blob)
    name { 'example.png' }
  end
end
