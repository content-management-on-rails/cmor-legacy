FactoryBot.define do
  factory :cmor_carousels_carousel, :class => Cmor::Carousels::Carousel do
    sequence(:identifier) { |i| "carousel_#{i}" }
  end
end

