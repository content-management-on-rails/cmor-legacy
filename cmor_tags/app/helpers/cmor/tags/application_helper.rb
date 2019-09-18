module Cmor
  module Tags
    module ApplicationHelper
      def tags_search_box
        @tag_search ||= Cmor::Tags::TagSearch.new
        render partial: 'cmor/tags/search_box'
      end
    end
  end
end
