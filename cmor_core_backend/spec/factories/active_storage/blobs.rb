FactoryBot.define do
  factory :active_storage_blob, class: 'ActiveStorage::Blob' do
    filename { 'example.png' }
    byte_size { File.size(Cmor::Core::Backend::Engine.root.join(*%w(spec files active_storage blob example.png))) }
    checksum { Digest::MD5.file(Cmor::Core::Backend::Engine.root.join(*%w(spec files active_storage blob example.png))).base64digest }
  end
end
