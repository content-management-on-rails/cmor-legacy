module Cmor
  module Cms
    class LayoutsController < Cmor::Core::Backend::ResourcesController::Base
      include Cmor::Transports::ResourcesController::ExportConcern if Cmor::Core.features?(:cmor_transports)
      include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)
      include Rao::ResourcesController::ActsAsPublishedConcern

      def self.resource_class
        Cmor::Cms::Layout
      end

      def self.has_paper_trail?
        Object.const_defined?('PaperTrail') && PaperTrail.request.enabled_for_model?(resource_class)
      end

      def self.available_rest_actions
        super + [:export, (has_paper_trail? ? :versions : nil)].compact
      end

      private

      def permitted_params
        params.require(:layout)
              .permit(:body, :pathname, :basename, :locale, :format, :handler, :published)
      end
    end
  end
end
