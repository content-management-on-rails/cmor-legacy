FactoryBot.define do
  factory :cmor_carousels_item_detail, class: Cmor::Carousels::ItemDetail do
    association :carousel, factory: :cmor_carousels_carousel
    asset { Rack::Test::UploadedFile.new(File.open(Cmor::Carousels::Engine.root.join(*%w[spec files cmor carousels item_details example.png]))) }
  end
end
