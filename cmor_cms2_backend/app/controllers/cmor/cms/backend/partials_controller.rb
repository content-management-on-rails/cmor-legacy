class Cmor::Cms::Backend::PartialsController < Cmor::Core::Backend::ResourcesController::Base
  def self.resource_class
    Cmor::Cms::Partial
  end

  private

  def permitted_params
    params.require(:partial)
          .permit(:body, :pathname, :basename, :locale, :format, :handler)
  end
end
