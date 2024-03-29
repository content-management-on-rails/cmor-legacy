module Cmor
  module Blog
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Blog::ApplicationViewHelper, as: :blog_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     = blog_helper(self).render_recent_posts(3)
      #
      def render_recent_posts(count)
        posts = Cmor::Blog::Post.published.for_locale.limit(count).all
        c.render html: posts.collect { |p| render_post(p.id) }.join("<hr />").html_safe
      end

      def render_post(id)
        post = Cmor::Blog::Post.published.for_locale.where(id: id).first
        render(post: post) if post.present?
      end

      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     - if controller.class.name.deconstantize == 'Cmor::Blog'
      #       = blog_helper(self).render_monthly_navigation
      #
      def render_monthly_navigation
        posts_by_month = Cmor::Blog::Post.published.all.pluck(:created_at).group_by { |t| t.beginning_of_month }
        render posts_by_month: posts_by_month
      end
    end
  end
end