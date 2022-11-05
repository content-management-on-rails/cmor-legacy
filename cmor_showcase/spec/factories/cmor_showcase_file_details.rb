FactoryBot.define do
  factory :cmor_showcase_file_detail, class: 'Cmor::Showcase::FileDetail' do
    association :item, factory: :cmor_showcase_item
    after(:build) { |resource|
      assets = resource.item.assets.attach(
        io:           File.open(File.join(Cmor::Showcase::Engine.root.join(*%w( spec files cmor showcase file_details example.png)))),
        filename:     'example.png',
        content_type: 'image/png'
      )
      resource.asset = resource.item.assets.first
    }
  end
end
