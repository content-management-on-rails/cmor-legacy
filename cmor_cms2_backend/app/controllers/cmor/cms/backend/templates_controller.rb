class Cmor::Cms::Backend::TemplatesController < Cmor::Core::Backend::ResourcesController::Base
  def self.resource_class
    Cmor::Cms::Template
  end

  private

  def permitted_params
    params.require(:template)
          .permit(:body, :pathname, :basename, :locale, :format, :handler)
  end
end
