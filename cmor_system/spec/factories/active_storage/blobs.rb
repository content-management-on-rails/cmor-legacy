FactoryBot.define do
  factory :active_storage_blob, class: 'ActiveStorage::Blob' do
    filename { 'example.png' }
    byte_size { File.size(Cmor::System::Engine.root.join(*%w(spec files active_storage blob example.png))) }
    checksum { Digest::MD5.file(Cmor::System::Engine.root.join(*%w(spec files active_storage blob example.png))).base64digest }
    after(:build) do |resource|
      resource.upload(File.open(Cmor::System::Engine.root.join(*%w(spec files active_storage blob example.png))))
    end
  end
end
