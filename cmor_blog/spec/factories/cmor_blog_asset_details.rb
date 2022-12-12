FactoryBot.define do
  factory :cmor_blog_asset_detail, class: Cmor::Blog::AssetDetail do
    association(:post, factory: :cmor_blog_post)
    asset { Rack::Test::UploadedFile.new(File.open(Cmor::Blog::Engine.root.join(*%w( spec files cmor blog post asset example.jpg)))) }
  end
end
