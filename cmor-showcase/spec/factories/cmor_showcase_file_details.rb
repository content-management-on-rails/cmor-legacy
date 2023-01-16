FactoryBot.define do
  factory :cmor_showcase_file_detail, class: 'Cmor::Showcase::FileDetail' do
    association :item, factory: :cmor_showcase_item
    asset { Rack::Test::UploadedFile.new(File.open(Cmor::Showcase::Engine.root.join(*%w( spec files cmor showcase file_details example.png)))) }
  end
end
