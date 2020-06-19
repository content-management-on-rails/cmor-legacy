module Cmor
  module Cms
    module Backend
      class TemplatesController < Cmor::Core::Backend::ResourcesController::Base
        include Cmor::Transports::ResourcesController::ExportConcern
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::Template
        end

        def self.available_rest_actions
          super + [:export]
        end

        private

        def permitted_params
          params.require(:template)
                .permit(:body, :pathname, :basename, :locale, :format, :handler, :published)
        end
      end
    end
  end
end
