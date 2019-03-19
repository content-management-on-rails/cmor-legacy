class Cmor::Cms::Backend::NavigationItemsController < Cmor::Core::Backend::ResourcesController::Base
  include Rao::ResourcesController::AwesomeNestedSetConcern

  def self.resource_class
    Cmor::Cms::NavigationItem
  end

  private

  def load_collection_scope
    super.joins(:cmor_cms_navigation).includes(:cmor_cms_page)
  end

  def permitted_params
    params.require(:navigation_item)
          .permit(:cmor_cms_navigation_id, :cmor_cms_page_id, :highlights_on, :key, :name, :parent_id, :options, :url, *Cmor::Cms::Configuration.navigation_item_properties)
  end
end
