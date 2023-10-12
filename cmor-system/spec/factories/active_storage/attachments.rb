FactoryBot.define do
  factory :active_storage_attachment, class: "ActiveStorage::Attachment" do
    association(:record, factory: Cmor::System::Configuration.record_factory_name)
    association(:blob, factory: :active_storage_blob)
    name { Cmor::System::Configuration.record_attachment_name }
  end
end
