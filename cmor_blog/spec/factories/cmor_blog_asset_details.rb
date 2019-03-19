FactoryBot.define do
  factory :cmor_blog_asset_detail, class: Cmor::Blog::AssetDetail do
    association(:post, factory: :cmor_blog_post)
    after(:build) { |resource| 
      assets = resource.post.assets.attach(
        io:           File.open(File.join(Cmor::Blog::Engine.root.join(*%w( spec files cmor blog asset example.jpg)))),
        filename:     'example.jpg',
        content_type: 'image/jpeg'
      )
      if Rails.version < "6.0.0"
        resource.asset = assets.first
      else
        resource.asset = resource.post.assets.first
      end
    }
  end
end
