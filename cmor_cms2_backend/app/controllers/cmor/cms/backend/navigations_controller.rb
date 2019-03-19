class Cmor::Cms::Backend::NavigationsController < Cmor::Core::Backend::ResourcesController::Base
  def self.resource_class
    Cmor::Cms::Navigation
  end

  private

  def permitted_params
    params.require(:navigation)
          .permit(:locale, :name)
  end
end
