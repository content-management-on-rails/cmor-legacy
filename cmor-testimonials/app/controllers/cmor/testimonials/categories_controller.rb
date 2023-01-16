module Cmor::Testimonials
  class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Testimonials::Category
    end

    private

    def permitted_params
      params.require(:category).permit(:locale, :identifier, :name)
    end
  end
end
