module Cmor::Tags
  module ApplicationHelper
    def tag_toolbar(options = {})
      render "cmor/tags/tag_toolbar"
    end

    def tag_labels_for(resource)
      render "cmor/tags/tag_labels_for_resource", resource: resource
    end
  end
end
