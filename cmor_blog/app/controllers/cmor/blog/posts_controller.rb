module Cmor
  module Blog
    class PostsController < Cmor::Blog::Configuration.base_controller.constantize
      include Rao::ResourcesController::ResourcesConcern
      include Rao::ResourcesController::ResourceInflectionsConcern
      include Rao::ResourcesController::RestResourceUrlsConcern
      include Rao::ResourcesController::RestActionsConcern
      include Rao::ResourcesController::KaminariConcern
      include Rao::ResourcesController::LocationHistoryConcern

      helper Cmor::Comments::ApplicationHelper if Cmor::Blog.features?(:cmor_comments)

      def self.resource_class
        Cmor::Blog::Post
      end

      private

      def load_collection_scope
        if params.has_key?(:year)
          super.published.for_date(params[:year], params[:month], params[:day])
        else
          super.published
        end
      end

      def load_resource_scope
        super.published.friendly
      end
    end
  end
end