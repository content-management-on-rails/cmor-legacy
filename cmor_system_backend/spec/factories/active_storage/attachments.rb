FactoryBot.define do
  factory :active_storage_attachment, class: 'ActiveStorage::Attachment' do
    association(:record, factory: :post)
    association(:blob, factory: :active_storage_blob)
    name { 'example.png' }
  end
end
