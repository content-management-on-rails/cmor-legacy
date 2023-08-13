module Cmor
  module Cms
    class PagesController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsPublishedConcern
      include Cmor::Transports::ResourcesController::ExportConcern if Cmor::Core.features?(:cmor_transports)
      include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)

      def self.resource_class
        Cmor::Cms::Page
      end

      def self.has_paper_trail?
        Object.const_defined?('PaperTrail') && PaperTrail.request.enabled_for_model?(resource_class)
      end

      def self.available_rest_actions
        super + [:export, (has_paper_trail? ? :versions : nil)].compact
      end

      private

      def permitted_params
        params.require(:page)
              .permit(:title, :meta_description, :body, :pathname, :basename, :locale, :format, :handler, :layout, :published, navigation_item_ids: [])
      end
    end
  end
end
