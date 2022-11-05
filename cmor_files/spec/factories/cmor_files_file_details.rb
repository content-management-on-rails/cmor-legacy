FactoryBot.define do
  factory :cmor_files_file_detail, class: 'Cmor::Files::FileDetail' do
    association :folder, factory: :cmor_files_folder
    after(:build) { |resource|
      assets = resource.folder.assets.attach(
        io:           File.open(File.join(Cmor::Files::Engine.root.join(*%w( spec files cmor files file_details example.png)))),
        filename:     'example.png',
        content_type: 'image/png'
      )
      resource.asset = resource.folder.assets.first
    }
  end
end
