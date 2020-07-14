module Cmor
  module Cms
    module Backend
      class LayoutsController < Cmor::Core::Backend::ResourcesController::Base
        include Cmor::Transports::ResourcesController::ExportConcern if Cmor::Core.features?(:cmor_transports)
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::Layout
        end

        def self.available_rest_actions
          super + [:export]
        end

        private

        def permitted_params
          params.require(:layout)
                .permit(:body, :pathname, :basename, :locale, :format, :handler, :published)
        end
      end
    end
  end
end
