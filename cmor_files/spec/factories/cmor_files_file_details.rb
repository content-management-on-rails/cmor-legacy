FactoryBot.define do
  factory :cmor_files_file_detail, class: 'Cmor::Files::FileDetail' do
    association :folder, factory: :cmor_files_folder
  end
end
