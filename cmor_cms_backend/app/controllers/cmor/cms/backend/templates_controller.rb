module Cmor
  module Cms
    module Backend
      class TemplatesController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::Template
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
