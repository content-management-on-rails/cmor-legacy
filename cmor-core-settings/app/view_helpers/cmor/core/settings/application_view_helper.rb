module Cmor
  module Core
    module Settings
      # Usage:
      #
      #     class ApplicationController < ActionController::Base
      #       view_helper Cmor::Core::Settings::ApplicationViewHelper, as: :settings_helper
      #     end
      #
      class ApplicationViewHelper < Rao::ViewHelper::Base
      end
    end
  end
end
