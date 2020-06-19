class Cmor::Cms::Backend::NavigationsController < Cmor::Core::Backend::ResourcesController::Base
  include Cmor::Transports::ResourcesController::ExportConcern

  def self.resource_class
    Cmor::Cms::Navigation
  end

  def self.available_rest_actions
    super + [:export]
  end

  private

  def permitted_params
    params.require(:navigation)
          .permit(:locale, :name)
  end
end
