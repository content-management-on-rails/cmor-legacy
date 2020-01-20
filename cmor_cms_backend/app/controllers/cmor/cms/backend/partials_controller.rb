module Cmor
  module Cms
    module Backend
      class PartialsController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::Partial
        end

        private

        def permitted_params
          params.require(:partial)
                .permit(:body, :pathname, :basename, :locale, :format, :handler, :published)
        end
      end
    end
  end
end
