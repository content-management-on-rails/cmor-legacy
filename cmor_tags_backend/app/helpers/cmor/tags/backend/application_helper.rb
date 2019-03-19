module Cmor
  module Tags
    module Backend
      module ApplicationHelper
        def tag_toolbar(options = {})
          render 'cmor/tags/backend/tag_toolbar'
        end

        def tag_labels_for(resource)
          render 'cmor/tags/backend/tag_labels_for_resource', resource: resource
        end
      end
    end
  end
end
