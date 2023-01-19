module Cmor
  module Links
    module Backend
      class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Cmor::Links::Category
        end

        private

        def permitted_params
          params
            .require(:category)
            .permit(:parent_id, :locale, :name, :short_description, :long_description, :link_footer_column, :identifier)
        end
      end
    end
  end
end