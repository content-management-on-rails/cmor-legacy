FactoryBot.define do
  factory :cmor_carousels_item_detail, class: Cmor::Carousels::ItemDetail do
    association :carousel, factory: :cmor_carousels_carousel
    after(:build) { |resource|
      assets = resource.carousel.assets.attach(
        io:           File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))),
        filename:     'example.png',
        content_type: 'image/png'
      )
      resource.asset = resource.carousel.assets.first
    }
  end
end

