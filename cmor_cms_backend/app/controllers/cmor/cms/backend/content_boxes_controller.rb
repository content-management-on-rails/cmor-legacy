class Cmor::Cms::Backend::ContentBoxesController < Cmor::Core::Backend::ResourcesController::Base
  def self.resource_class
    Cmor::Cms::ContentBox
  end

  private

  def permitted_params
    params.require(:content_box).permit(:name)
  end
end
