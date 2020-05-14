module Cmor
  module Cms
    module Backend
      class LayoutsController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::Layout
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
