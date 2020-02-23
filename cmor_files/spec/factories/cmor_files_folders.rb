FactoryBot.define do
  factory :cmor_files_folder, class: 'Cmor::Files::Folder' do
    sequence(:name) { |i| "Folder ##{i}" }
    sequence(:identifier) { |i| "folder-#{i}" }
  end
end
