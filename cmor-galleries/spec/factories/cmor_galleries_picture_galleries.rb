FactoryBot.define do
  factory :cmor_galleries_picture_gallery, class: "Cmor::Galleries::PictureGallery" do
    sequence(:name) { |i| "Picture Gallery ##{i}" }
  end
end
