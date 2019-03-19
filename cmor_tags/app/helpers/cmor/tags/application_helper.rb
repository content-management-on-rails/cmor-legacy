module Cmor
  module Tags
    module ApplicationHelper
      def tags_search_box
        @tag_search ||= Cmor::Tags::TagSearch.new
        render partial: 'cmor/tags/search_box'
      end

      def tag_labels_for(resource)
        render 'cmor/tags/tag_labels_for_resource', resource: resource
      end
    end
  end
end
