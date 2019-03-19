module Cmor
  module Core
    class HomeController < Cmor::Core::Configuration.base_controller.constantize

      def index
        render plain: 'Welcome!'
      end
    end
  end
end
