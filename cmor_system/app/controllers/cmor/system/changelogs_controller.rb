module Cmor
  module System
    class ChangelogsController < Cmor::Core::Backend::ResourcesController::Base
      view_helper Markup::Rails::ApplicationViewHelper, as: :markup_helper

      def self.resource_class
        Cmor::System::Changelog
      end

      def self.available_rest_actions
        %i(index show)
      end

      private

      def permitted_params
        params.require(:changelog).permit()
      end

      def load_collection
        # @collection = if respond_to?(:per_page)
        @collection = if Object.const_defined?('Kaminari')
          Kaminari.paginate_array(self.resource_class.all).page(params[:page]).per(per_page)
        else
          super
        end
      end
    end
  end
end
