# frozen_string_literal: true

module Cmor::Seo
  class MetaTagsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Seo::MetaTag
    end

    private

    def current_user_for_userstamp
      Cmor::Seo::Configuration.current_user_proc.call(self)
    end

    def initialize_resource_for_create
      super
      @resource.creator = current_user_for_userstamp
    end

    def before_rest_action
      @resource.updater = current_user_for_userstamp if %w[update destroy].include?(action_name)
    end

    def load_collection_scope
      super.includes(:item)
    end

    def after_reposition_location
      last_location
    end

    def permitted_params
      params.require(:meta_tag).permit(:item_id, :name, :content, :published)
    end
  end
end
