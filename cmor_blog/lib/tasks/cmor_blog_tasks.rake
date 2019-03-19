namespace :cmor do
  namespace :blog do
    desc "Initializes Post positions"
    task initialize_post_positions: :environment do
      Cmor::Blog::Post.order(created_at: :desc).each.with_index(1) do |post, index|
        post.update_column :position, index
      end
    end
  end
end