class Cmor::Cms::Backend::PagesController < Cmor::Core::Backend::ResourcesController::Base
  def self.resource_class
    Cmor::Cms::Page
  end

  private

  def permitted_params
    params.require(:page)
          .permit(:title, :meta_description, :body, :pathname, :basename, :locale, :format, :handler, :layout, cmor_cms_navigation_item_ids: [])
  end
end
