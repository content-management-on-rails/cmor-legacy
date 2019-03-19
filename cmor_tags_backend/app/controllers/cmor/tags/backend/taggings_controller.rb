module Cmor::Tags::Backend
  class TaggingsController < Cmor::Core::Backend::ResourcesController::Base
    before_action :normalize_global_ids, only: [:create, :update]

    def self.resource_class
      Cmor::Tags::Tagging
    end

    def create_by_gid_and_tag
      @taggable = load_taggable
      @tag      = load_tag
      @taggable.tags << @tag

      respond_to do |format|
        format.js { flash.now[:notice] = t('.success') }
      end
    end

    def set_by_gid_and_tag
      @taggable = load_taggable
      @tag      = load_tag
      @taggable.tags = [@tag]

      respond_to do |format|
        format.js { flash.now[:notice] = t('.success') }
      end
    end

    private

    def normalize_global_ids
      taggable_gid = params[:tagging].delete(:taggable)
      params[:tagging][:taggable] = GlobalID::Locator.locate(taggable_gid)

      tagger_gid = params[:tagging].delete(:tagger)
      params[:tagging][:tagger] = GlobalID::Locator.locate(tagger_gid)
    end

    def load_taggable
      GlobalID::Locator.locate(params[:gid])
    end

    def load_tag
      Cmor::Tags::Tag.find(params[:tag_id])
    end

    def permitted_params
      params.require(:tagging).permit(:name, :tag_id, :taggable, :tagger, :context)
    end
  end
end
