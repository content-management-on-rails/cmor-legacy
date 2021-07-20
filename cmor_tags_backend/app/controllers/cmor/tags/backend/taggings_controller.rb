module Cmor::Tags::Backend
  class TaggingsController < Cmor::Core::Backend::ResourcesController::Base
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

    def load_taggable
      GlobalID::Locator.locate(params[:gid])
    end

    def load_tag
      Cmor::Tags::Tag.find(params[:tag_id])
    end

    def permitted_params
      params.require(:tagging).permit(:name, :tag_id, :tagger, :taggable, :context)
    end
  end
end
