class AddPositionToCmorBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_blog_posts, :position, :integer
  end
end
