module Cmor
  module Cms
    class NavigationItemsController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::AwesomeNestedSetConcern
      include Rao::ResourcesController::ActsAsPublishedConcern
      include Cmor::Transports::ResourcesController::ExportConcern if Cmor::Core.features?(:cmor_transports)
      include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)

      def self.resource_class
        Cmor::Cms::NavigationItem
      end

      def self.has_paper_trail?
        Object.const_defined?('PaperTrail') && PaperTrail.request.enabled_for_model?(resource_class)
      end

      def self.available_rest_actions
        super + [:export, (has_paper_trail? ? :versions : nil)].compact
      end

      private

      def load_collection_scope
        super.joins(:navigation).includes(:page)
      end

      def permitted_params
        params.require(:navigation_item)
              .permit(:navigation_id, :page_id, :highlights_on, :key, :name, :parent_id, :options, :url, :published, *Cmor::Cms::Configuration.navigation_item_properties)
      end
    end
  end
end
