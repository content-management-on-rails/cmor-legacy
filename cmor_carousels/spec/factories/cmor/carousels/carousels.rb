FactoryBot.define do
  factory :cmor_carousels_carousel, :class => Cmor::Carousels::Carousel do
    sequence(:identifier) { |i| "carousel_#{i}" }

    factory :cmor_carousels_carousel_with_items do |carousel|
      carousel.after_create { |s| FactoryBot.create_list(:cmor_carousels_item, 5, cmor_carousels_carousel: s) }
    end
  end
end

