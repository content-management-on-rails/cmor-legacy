module Cmor::Tags
  class TagsController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Tags::Tag
    end

    respond_to :js

    private

    def permitted_params
      params.require(:tag).permit(:name, :color)
    end
  end
end
