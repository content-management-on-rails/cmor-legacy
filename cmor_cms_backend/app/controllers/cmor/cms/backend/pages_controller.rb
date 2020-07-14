module Cmor
  module Cms
    module Backend
      class PagesController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsPublishedConcern
        include Cmor::Transports::ResourcesController::ExportConcern if Cmor::Core.features?(:cmor_transports)
        include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)

        def self.resource_class
          Cmor::Cms::Page
        end

        def self.available_rest_actions
          super + [:export]
        end

        private

        def permitted_params
          params.require(:page)
                .permit(:title, :meta_description, :body, :pathname, :basename, :locale, :format, :handler, :layout, :published, navigation_item_ids: [])
        end
      end
    end
  end
end
