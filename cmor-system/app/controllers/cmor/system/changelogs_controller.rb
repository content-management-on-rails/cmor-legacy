module Cmor
  module System
    class ChangelogsController < Cmor::Core::Backend::ResourcesController::Base
      view_helper Markup::Rails::ApplicationViewHelper, as: :markup_helper

      def self.resource_class
        Cmor::System::Changelog
      end

      def self.available_rest_actions
        %i[index show]
      end

      private

      def permitted_params
        params.require(:changelog).permit
      end
    end
  end
end
