FactoryBot.define do
  factory :cmor_galleries_picture_detail, class: "Cmor::Galleries::PictureDetail" do
    association :picture_gallery, factory: :cmor_galleries_picture_gallery
    asset { Rack::Test::UploadedFile.new(File.open(Cmor::Galleries::Engine.root.join(*%w[spec files cmor galleries picture_details example.png]))) }
  end
end
