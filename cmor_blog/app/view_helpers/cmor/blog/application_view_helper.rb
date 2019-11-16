module Cmor
  module Blog
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_recent_posts(count)
        posts = Cmor::Blog::Post.limit(count).all
        c.render html: posts.collect { |p| render_post(p.id) }.join("<hr />").html_safe
      end

      def render_post(id)
        post = Cmor::Blog::Post.where(id: id).first
        render(post: post) if post.present?
      end
    end
  end
end