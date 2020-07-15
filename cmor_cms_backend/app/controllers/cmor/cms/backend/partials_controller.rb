module Cmor
  module Cms
    module Backend
      class PartialsController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsPublishedConcern
        include Cmor::Transports::ResourcesController::ExportConcern if Cmor::Core.features?(:cmor_transports)
        include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)

        def self.resource_class
          Cmor::Cms::Partial
        end

        def self.has_paper_trail?
          PaperTrail.request.enabled_for_model?(resource_class)
        end

        def self.available_rest_actions
          super + [:export, (has_paper_trail? ? :versions : nil)].compact
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
