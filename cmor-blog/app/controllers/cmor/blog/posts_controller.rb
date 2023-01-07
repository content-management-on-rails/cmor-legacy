module Cmor
  module Blog
    class PostsController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsListConcern
      include Rao::ResourcesController::ActsAsPublishedConcern
      include Rao::ResourcesController::FriendlyIdConcern

      include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)

      helper Cmor::Tags::ApplicationHelper if Cmor::Core.features?(:cmor_tags)

      include Rao::Query::Controller::QueryConcern
      view_helper Rao::Query::ApplicationHelper, as: :query_helper

      def self.resource_class
        Cmor::Blog::Post
      end

      private

      def current_user_for_userstamp
        Cmor::Blog::Configuration.current_user_proc.call(self)
      end

      def initialize_resource
        super
        @resource.creator = current_user_for_userstamp
      end

      def initialize_resource_for_create
        super
        @resource.creator = current_user_for_userstamp
      end

      def load_collection_scope
        scope = super.friendly
        with_conditions_from_query(scope)
      end

      def load_resource_scope
        super.friendly
      end

      def permitted_params
        params.require(:post).permit(:locale, :title, :body, :published, :tag_list, append_asset_detail_assets: [], overwrite_asset_detail_assets: [])
      end
    end
  end
end
